//
//  RootRouterTests.swift
//  APODTests
//
//  Created by Sakiwei on 10/1/2022.
//

import XCTest
@testable import APOD

class RootRouterTests: XCTestCase {

    class MockRootRouteNavigationController: RootRouteNavigatable {
        var isPresentedDatePicker = false
        func present(withDatePicker datePicker: UIViewController) {
            isPresentedDatePicker = true
        }
    }

    var mockRouteNavController: MockRootRouteNavigationController!
    var rootRouter: RootRouter!

    override func setUp() {
        super.setUp()
        mockRouteNavController = MockRootRouteNavigationController()
        rootRouter = RootRouterImpl(controller: mockRouteNavController)
    }

    func testRootRouter_openDatePicker() {
        let date = Date()
        rootRouter.openDatePicker(initialDate: date) { _ in
        }
        XCTAssertTrue(mockRouteNavController.isPresentedDatePicker)
    }
}
