//
//  RoomiUITests.swift
//  RoomiUITests
//
//  Created by Alec Morrison on 10/11/24.
//

import XCTest

final class RoomiUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
    
    @MainActor
    func testTabNavigation() throws {
        let matchesButton = app.buttons["Matches"]
        XCTAssertTrue(matchesButton.waitForExistence(timeout: 5), "Matches button should exist.")
        matchesButton.tap()
        XCTAssertTrue(app.otherElements["MatchesView"].exists, "MatchesView should load when Matches tab is tapped.")
        
        let homeButton = app.buttons["Home"]
        XCTAssertTrue(homeButton.waitForExistence(timeout: 5), "Home button should exist.")
        homeButton.tap()
        XCTAssertTrue(app.otherElements["CardStackView"].exists, "CardStackView should load when Home tab is tapped.")
        
        let profileButton = app.buttons["Profile"]
        XCTAssertTrue(profileButton.waitForExistence(timeout: 5), "Profile button should exist.")
        profileButton.tap()
        XCTAssertTrue(app.otherElements["ProfileView"].exists, "ProfileView should load when Profile tab is tapped.")
    }
    
    @MainActor
    func testTabTransitionAnimation() throws {
        let matchesButton = app.buttons["Matches"]
        XCTAssertTrue(matchesButton.waitForExistence(timeout: 5), "Matches button should exist.")
        matchesButton.tap()
        
        let homeButton = app.buttons["Home"]
        XCTAssertTrue(homeButton.waitForExistence(timeout: 5), "Home button should exist.")
        homeButton.tap()
    }
}
