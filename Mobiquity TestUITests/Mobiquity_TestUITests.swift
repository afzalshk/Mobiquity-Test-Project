//
//  Mobiquity_TestUITests.swift
//  Mobiquity TestUITests
//
//  Created by Afzal Murtaza on 21/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import XCTest

class Mobiquity_TestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchResult() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Mobiquity_Test.MainView"].searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Kitten")
        app.buttons["Search"].tap()
        let loaded = NSPredicate(format: "count > 0")
        let collectionView = app.collectionViews.element
        expectation(for: loaded, evaluatedWith: collectionView.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testSearchAction() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Mobiquity_Test.MainView"]/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".staticTexts.searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let kKey = app/*@START_MENU_TOKEN@*/.keys["K"]/*[[".keyboards.keys[\"K\"]",".keys[\"K\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.isEnabled)
    }
    func testHistoryAction() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Mobiquity_Test.MainView"].buttons["arrow.clockwise.circle"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Recent Searches")

    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
