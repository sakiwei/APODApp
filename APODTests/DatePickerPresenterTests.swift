//
//  DatePickerPresenterTests.swift
//  APODTests
//
//  Created by Sakiwei on 10/1/2022.
//

import XCTest
@testable import APOD

class DatePickerPresenterTests: XCTestCase {

    class MockDatePickerView: DatePickerView {
        var displayDate: Date?
        func datePickerDidUpdate(_ date: Date) {
            displayDate = date
        }
    }

    class MockDatePickerInteractor: DatePickerInteractor {

    }

    class MockDatePickerRouter: DatePickerRouter {
        var isDismissed = false
        var displayDate: Date?
        func dismiss(withDate date: Date) {
            isDismissed = true
            displayDate = date
        }
    }

    var mockView: MockDatePickerView!
    var mockInteractor: MockDatePickerInteractor!
    var mockRouter: MockDatePickerRouter!
    var presenter: DatePickerPresenter!
    var fakeSelectedDate = Date()

    override func setUp() {
        super.setUp()
        mockView = MockDatePickerView()
        mockInteractor = MockDatePickerInteractor()
        mockRouter = MockDatePickerRouter()
        presenter = DatePickerPresenterImpl(view: mockView,
                                            interactor: mockInteractor,
                                            router: mockRouter,
                                            selectedDate: fakeSelectedDate)
    }

    func testRootPresenter_viewDidLoad() async throws {
        presenter.viewDidLoad()
        XCTAssertEqual(mockView.displayDate, fakeSelectedDate)
    }

    func testRootPresenter_changeDate() async throws {
        let newDate = Date()
        presenter.change(selectedDate: newDate)
        XCTAssertNotEqual(presenter.selectedDate, fakeSelectedDate)
        XCTAssertEqual(presenter.selectedDate, newDate)
    }

    func testRootPresenter_dismiss() async throws {
        presenter.dismiss()
        XCTAssertTrue(mockRouter.isDismissed)
        XCTAssertEqual(mockRouter.displayDate, fakeSelectedDate)
    }
}
