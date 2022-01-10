//
//  RootInteractorTests.swift
//  APODTests
//
//  Created by Sakiwei on 10/1/2022.
//

import XCTest
import DataModel
import Networking

@testable import APOD

class RootInteractorTests: XCTestCase {

    class MockFetchDailyPictureService: FetchDailyPictureService {
        var picture: AstronomyPicture
        var cachedPicture: AstronomyPicture?
        var fetchPictureError: Error?

        init(picture: AstronomyPicture) {
            self.picture = picture
        }

        func fetchPicture(onDate date: Date) async throws -> AstronomyPicture {
            if let fetchPictureError = fetchPictureError {
                throw fetchPictureError
            }
            return picture
        }

        func loadCachedPicture(onDate date: Date) throws -> AstronomyPicture? {
            if cachedPicture == nil,
               let fetchPictureError = fetchPictureError {
                throw fetchPictureError
            }
            return cachedPicture
        }
    }

    var mockService: MockFetchDailyPictureService!
    var interactor: RootInteractor!
    let fakePicture = AstronomyPicture(copyright: "copyright",
                                       date: "2022-01-01",
                                       explanation: "explanation",
                                       mediaType: "image",
                                       serviceVersion: "v1",
                                       title: "title",
                                       url: "https://www.domain.com/image.jpg",
                                       hdurl: "https://www.domain.com/image-hd.jpg")

    let fakeCachedPicture = AstronomyPicture(copyright: "copyright",
                                             date: "2022-01-01",
                                             explanation: "explanation",
                                             mediaType: "image",
                                             serviceVersion: "v1",
                                             title: "title cached",
                                             url: "https://www.domain.com/image.jpg",
                                             hdurl: "https://www.domain.com/image-hd.jpg")

    override func setUp() {
        super.setUp()
        mockService = MockFetchDailyPictureService(picture: fakePicture)
        interactor = RootInteractorImpl(service: mockService)
    }

    func testRootInteractor_loadPictureSuccess() async throws {
        let date = Date()
        let picture = try await interactor.loadPicture(onDate: date)
        XCTAssertEqual(fakePicture, picture)
        XCTAssertNotEqual(fakeCachedPicture, picture)
    }

    func testRootInteractor_loadPictureFailure_withCache() async throws {
        let date = Date()
        mockService.cachedPicture = fakeCachedPicture
        mockService.fetchPictureError = NetworkError.invalidResponse
        let picture = try await interactor.loadPicture(onDate: date)
        XCTAssertEqual(fakeCachedPicture, picture)
        XCTAssertNotEqual(fakePicture, picture)
    }

    func testRootInteractor_loadPictureFailure_withoutCache() async throws {
        let date = Date()
        mockService.fetchPictureError = NetworkError.invalidResponse
        do {
            _ = try await interactor.loadPicture(onDate: date)
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(error is NetworkError)
        }
    }
}
