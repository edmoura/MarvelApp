//
//  MarvelAppUITests.swift
//  MarvelAppUITests
//
//  Created by Edson iMAC on 25/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import XCTest

class MarvelAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        snapshot("0Launch")
        
        XCUIDevice.shared.orientation = .portrait
        snapshot("1portrait")
        sleep(1)
        XCUIDevice.shared.orientation = .landscapeRight
        snapshot("2landscapeRight")
        sleep(1)
        XCUIDevice.shared.orientation = .portrait
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let backButton = app.navigationBars["Details"].buttons["Back"]
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["A-Bomb (HAS)"]/*[[".cells.staticTexts[\"A-Bomb (HAS)\"]",".staticTexts[\"A-Bomb (HAS)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("3Details")
        sleep(1)
        
        XCUIDevice.shared.orientation = .landscapeRight
        snapshot("4DetailslandscapeRight")
        
        let aBombHasElement = app.scrollViews.otherElements.containing(.staticText, identifier:"A-Bomb (HAS)").element
        aBombHasElement.tap()
        aBombHasElement.swipeLeft()
        XCUIDevice.shared.orientation = .portrait
        backButton.tap()
        XCUIDevice.shared.orientation = .faceUp

    }
    
}
