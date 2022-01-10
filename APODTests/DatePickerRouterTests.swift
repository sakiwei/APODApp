//
//  DatePickerRouterTests.swift
//  APODTests
//
//  Created by Sakiwei on 10/1/2022.
//

import XCTest
@testable import APOD

class DatePickerRouterTests: XCTestCase {

    class MockDatePickerRouteNavigationController: DatePickerRouteNavigatable {
        var isDismissed = false
        func dismiss() {
            isDismissed = true
        }
    }

    var mockRouteNavController: MockDatePickerRouteNavigationController!
    var router: DatePickerRouter!

    override func setUp() {
        super.setUp()
        mockRouteNavController = MockDatePickerRouteNavigationController()
    }

    func testDatePickerRouter_dismissWithDate() {

        let dateChangeExpectation = self.expectation(description: "`onDateChange` should be called")
        var callbackDate: Date?
        router = DatePickerRouterImpl(controller: mockRouteNavController,
                                      onDateChange: { date in
            callbackDate = date
            dateChangeExpectation.fulfill()
        })

        let now = Date()
        router.dismiss(withDate: now)
        wait(for: [dateChangeExpectation], timeout: 0.1)

        XCTAssertTrue(mockRouteNavController.isDismissed)
        XCTAssertEqual(callbackDate, now)
    }
}
