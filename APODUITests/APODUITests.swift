//
//  APODUITests.swift
//  APODUITests
//
//  Created by Sakiwei on 7/1/2022.
//

import XCTest

class APODUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_appLaunchScreenLayout() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launchEnvironment["UITesting"] = "T"
        app.launch()
        let navigationBar = app.navigationBars["Astronomy Picture of the Day"]

        XCTAssert(navigationBar.exists)
        XCTAssert(navigationBar.buttons["Show Calendar"].exists)
        XCTAssert(app.images["Cover Image"].exists)
        XCTAssert(app.buttons["View Button"].exists)
    }

    func test_openCalendar() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launchEnvironment["UITesting"] = "T"
        app.launch()
        app.navigationBars["Astronomy Picture of the Day"].buttons["Show Calendar"].tap()
        XCTAssert(app.staticTexts["Select Date Title"].waitForExistence(timeout: 2))

        app.navigationBars["Astronomy Picture of the Day"].buttons["Show Calendar"].tap()
        XCTAssert(app.datePickers["Date Picker"].waitForExistence(timeout: 2))
    }
}
