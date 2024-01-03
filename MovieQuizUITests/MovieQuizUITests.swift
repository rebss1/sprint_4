//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Илья Лощилов on 11.12.2023.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil

    }
    
    func testYesButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        let indexLabel = app.staticTexts["Index"]
        
        app.buttons["Yes"].tap()
        
        sleep(3)
        let newPoster = app.images["Poster"]
        let newPosterData = newPoster.screenshot().pngRepresentation

        XCTAssertNotEqual(firstPosterData, newPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testNoButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        let indexLabel = app.staticTexts["Index"]
        
        app.buttons["No"].tap()
        
        sleep(3)
        let newPoster = app.images["Poster"]
        let newPosterData = newPoster.screenshot().pngRepresentation

        XCTAssertNotEqual(firstPosterData, newPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testAlertAppears() {
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Игра окончена!"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.label, "Игра окончена!")
        XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграть заново!")
    }
    
    func testAlertDismiss() {
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Игра окончена!"]
        alert.buttons.firstMatch.tap()
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertEqual(indexLabel.label, "1/10")
    }
}
