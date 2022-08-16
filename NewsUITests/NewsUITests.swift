//
//  NewsUITests.swift
//  NewsUITests
//
//  Created by Neosoft on 11/08/22.
//

import XCTest
import Nimble
class NewsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //MARK: OnBoarding Flow
        let categoryDropDown = app.textFields["categoryDropDown"]
        let countryDropDown = app.textFields["countryDropDown"]
        let startButton = app.buttons["startButton"]
        categoryDropDown.tap()
        if app.tables["categoryDropDown"].waitForExistence(timeout: 5) {
            let cell = app.tables["categoryDropDown"].cells.matching(.cell, identifier: "categoryDropDown_1")
            cell.element.tap()
            expect(categoryDropDown.value as! String).toEventually(equal("Entertainment".capitalized))
        }
        countryDropDown.tap()
        if app.tables["countryDropDown"].waitForExistence(timeout: 5) {
            let cell = app.tables["countryDropDown"].cells.matching(.cell, identifier: "countryDropDown_1")
            cell.element.tap()
            expect(countryDropDown.value as! String).toEventually(equal("Canada".capitalized))
        }
        // Move to news list view
        startButton.tap()
        
        
        //MARK: News List Flow
        if app.tables["newsListTableView"].waitForExistence(timeout: 5) {
            let newsListTableView = app.tables["newsListTableView"]
            let newsListSearchBar = app.textFields["newsListSearchBar"]
            let cell = newsListTableView.cells.element(boundBy: 0)
            expect(cell.identifier).to(equal("NewsTableViewCell_0"))
            // Move to news detail view
            cell.tap()
        }
        
        //MARK: News List Flow
        if app.otherElements["newsDetailView"].waitForExistence(timeout: 5) {
            expect(app.navigationBars.element.identifier).to(equal("News"))
            //Go back
            app.navigationBars.buttons.element(boundBy: 0).tap()
            
        }
    }

}
