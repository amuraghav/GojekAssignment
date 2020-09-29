//
//  GojekAssignmentUITests.swift
//  GojekAssignmentUITests
//
//  Created by Pankaj Raghav on 26/09/20.
//

import XCTest

class GojekAssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAssignment() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let tablesQuery = app.tables
        tablesQuery.element(boundBy: 0).cells.element(boundBy: 0).tap()
        sleep(3)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        if tablesQuery.element(boundBy: 0).cells.element(boundBy: 5).exists{
            tablesQuery.element(boundBy: 0).cells.element(boundBy: 5).tap()
            sleep(3)
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
        tablesQuery.firstMatch.swipeDown()
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
                    }
    }
}
