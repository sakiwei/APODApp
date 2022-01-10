//
//  APODTests.swift
//  APODTests
//
//  Created by Sakiwei on 10/1/2022.
//

import XCTest
import DataModel
import Networking

@testable import APOD

class RootPresenterTests: XCTestCase {

    class MockRootView: RootView {
        var shouldPictureContentLoaded = false
        var shouldHideLoadingIndicator = false
        var shouldShowLoadingIndicator = false
        var shouldShowError = false
        var pictureContent: PictureViewModel?
        var errorMessage: String?

        func hideLoadingIndicator() {
            shouldHideLoadingIndicator = true
        }

        func pictureContentDidLoad(_ content: PictureViewModel) {
            shouldPictureContentLoaded = true
            pictureContent = content
        }

        func showError(message: String) {
            shouldShowError = true
            errorMessage = message
        }

        func showLoadingIndicator() {
            shouldShowLoadingIndicator = true
        }
    }

    class MockRootInteractor: RootInteractor {
        var isLoadedPicture = false
        var error: Error?
        var picture: AstronomyPicture
        init(picture: AstronomyPicture) {
            self.picture = picture
        }
        func loadPicture(onDate date: Date) async throws -> AstronomyPicture {
            isLoadedPicture = true
            if let error = error {
                throw error
            }
            return picture
        }
    }

    class MockRootRouter: RootRouter {
        var isOpenedDatePicker = false
        func openDatePicker(initialDate: Date, onDateChange: @escaping (Date) -> Void) {
            isOpenedDatePicker = true
        }
    }

    var mockView: MockRootView!
    var mockInteractor: MockRootInteractor!
    var mockRouter: MockRootRouter!
    var presenter: RootPresenter!

    override func setUp() {
        super.setUp()
        mockView = MockRootView()
        let fakePicture = AstronomyPicture(copyright: "copyright",
                                           date: "2022-01-01",
                                           explanation: "explanation",
                                           mediaType: "image",
                                           serviceVersion: "v1",
                                           title: "title",
                                           url: "https://www.domain.com/image.jpg",
                                           hdurl: "https://www.domain.com/image-hd.jpg")
        mockInteractor = MockRootInteractor(picture: fakePicture)
        mockRouter = MockRootRouter()
        presenter = RootPresenterImpl(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRootPresenter_viewDidLoad_loadPictureSuccess() async throws {
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertTrue(mockInteractor.isLoadedPicture)
        XCTAssertTrue(mockView.shouldShowLoadingIndicator)
        XCTAssertTrue(mockView.shouldHideLoadingIndicator)
        XCTAssertTrue(mockView.shouldPictureContentLoaded)
        XCTAssertEqual(mockView.pictureContent as! AstronomyPicture, mockInteractor.picture)
        XCTAssertNil(mockView.errorMessage)
    }

    func testRootPresenter_viewDidLoad_loadPictureFailure() async throws {
        mockInteractor.error = NetworkError.invalidResponse
        presenter.viewDidLoad()
        try await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertTrue(mockInteractor.isLoadedPicture)
        XCTAssertTrue(mockView.shouldShowLoadingIndicator)
        XCTAssertTrue(mockView.shouldHideLoadingIndicator)
        XCTAssertFalse(mockView.shouldPictureContentLoaded)
        XCTAssertNil(mockView.pictureContent)
        XCTAssertNotNil(mockView.errorMessage)
    }

    func testRootPresenter_openDatePicker() async throws {
        presenter.openDatePicker()
        XCTAssertTrue(mockRouter.isOpenedDatePicker)
    }

}
