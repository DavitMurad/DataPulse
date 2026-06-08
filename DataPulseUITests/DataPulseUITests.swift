//
//  DataPulseUITests.swift
//  DataPulseUITests
//
//  Created by Davit Muradyan on 31.05.26.
//

import XCTest

final class DataPulseUITests: XCTestCase {
    // Naming structure used to be - test_UnitOFWork_StateUnderTest_expectedBehavior or
    //                               test_[struct or class]_[variable or function]_[expected result]
    let app = XCUIApplication()
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {}
    
    
    func test_allCategoryCardsExistWhenLaunched() {
        
        let stepsCard = app.otherElements["Steps"]
        let weightCard = app.otherElements["Weight"]
        let calsCard = app.otherElements["Calories"]
        let climbedCard =  app.otherElements["Climbed"]
       
        XCTAssertTrue(stepsCard.waitForExistence(timeout: 3))
        XCTAssert(weightCard.exists)
        XCTAssert(calsCard.exists)
        XCTAssert(climbedCard.exists)
    }
    
    func test_CalatogueView_shouldOpenStepView() {
        // Given

        // When
        let stepstCard = app.otherElements["Steps"]

        XCTAssertTrue(stepstCard.waitForExistence(timeout: 3))
        stepstCard.tap()
        // Then
        
        let stepsForTodayLabel = app.staticTexts["Your steps for today."]
        
        XCTAssertTrue(stepsForTodayLabel.waitForExistence(timeout: 3))
    }
    
    func test_CalatogueView_shouldOpenStepViewAndCloseUponXMarkTap() {
        // Given

        
        // When
        let stepstCard = app.otherElements["Steps"]

        XCTAssertTrue(stepstCard.waitForExistence(timeout: 3))
        stepstCard.tap()
        
        // Then
        let stepsForTodayLabel = app.staticTexts["Your steps for today."]
        
        XCTAssertTrue(stepsForTodayLabel.waitForExistence(timeout: 3))

        let xmarkButton = app.buttons["xmark"]
        xmarkButton.tap()
       
        XCTAssertTrue(stepsForTodayLabel.waitForNonExistence(timeout: 3))
    }
    
    func test_CalatogueView_shouldOpenStepViewAndCloseUponXMarkTapStress() {
        // Given

        
        // When
        for _ in 0..<5 {
            let stepstCard = app.otherElements["Steps"]
            
            XCTAssertTrue(stepstCard.waitForExistence(timeout: 3))
            stepstCard.tap()
            
            // Then
            let stepsForTodayLabel = app.staticTexts["Your steps for today."]
            
            XCTAssertTrue(stepsForTodayLabel.waitForExistence(timeout: 3))
            
            let xmarkButton = app.buttons["xmark"]
            xmarkButton.tap()
            
            XCTAssertTrue(stepsForTodayLabel.waitForNonExistence(timeout: 3))
        }
    }
    
    func test_CalatogueView_shouldOpenWeightView() {

        // Given
        // When
        let weightCard = app.otherElements["Weight"]

        XCTAssertTrue(weightCard.waitForExistence(timeout: 3))
        weightCard.tap()
        // Then
        let avgWeightLabel = app.staticTexts["Your weight this week on average."]
        XCTAssertTrue(avgWeightLabel.waitForExistence(timeout: 3))
        
    }
    
    func test_CalatogueView_shouldOpenWeightViewAndCloseUponXMarkTap() {
        // Given
        // When
        let weightCard = app.otherElements["Weight"]

        XCTAssertTrue(weightCard.waitForExistence(timeout: 3))
        weightCard.tap()
        // Then
        let avgWeightLabel = app.staticTexts["Your weight this week on average."]
        XCTAssertTrue(avgWeightLabel.waitForExistence(timeout: 3))

        
        let xmarkButton = app.buttons["xmark"]
        xmarkButton.tap()
    
        XCTAssertTrue(avgWeightLabel.waitForNonExistence(timeout: 3))
    }
    
    
    func test_CalatogueView_shouldOpenWeightViewAndCloseUponXMarkTapStress() {
        // Given
        // When
        for _ in 0..<5 {
            let weightCard = app.otherElements["Weight"]
            
            XCTAssertTrue(weightCard.waitForExistence(timeout: 3))
            weightCard.tap()
            // Then
            let avgWeightLabel = app.staticTexts["Your weight this week on average."]
            XCTAssertTrue(avgWeightLabel.waitForExistence(timeout: 3))
            
            let xmarkButton = app.buttons["xmark"]
            xmarkButton.tap()
            
            XCTAssertTrue(avgWeightLabel.waitForNonExistence(timeout: 3))
        }
    }
    
    func test_CalatogueView_shouldOpenCaloriesView() {
        
        // Given
        // When
        let caloriesCard = app.otherElements["Calories"]

        XCTAssertTrue(caloriesCard.waitForExistence(timeout: 3))
        caloriesCard.tap()
        // Then
        let burnedCaloriesTodayLabel = app.staticTexts["Burned calories today."]
        
        XCTAssertTrue(burnedCaloriesTodayLabel.waitForExistence(timeout: 3))

        
    }
    
    func test_CalatogueView_shouldOpenCaloriesViewAndCloseUponXMarkTap() {
        // Given
        // When
        let caloriesCard = app.otherElements["Calories"]

        XCTAssertTrue(caloriesCard.waitForExistence(timeout: 3))
        caloriesCard.tap()
    
        // Then
        let burnedCaloriesTodayLabel = app.staticTexts["Burned calories today."]
        
        XCTAssertTrue(burnedCaloriesTodayLabel.waitForExistence(timeout: 3))

        
        let xmarkButton = app.buttons["xmark"]
        xmarkButton.tap()
        
        XCTAssertTrue(burnedCaloriesTodayLabel.waitForNonExistence(timeout: 3))

        
    }
    
    func test_CatalogueView_shouldOpenAndCloseCaloriesViewStress() {

        for _ in 0..<5 {

            let caloriesCard = app.otherElements["Calories"]

            XCTAssertTrue(caloriesCard.waitForExistence(timeout: 3))
            caloriesCard.tap()

            let burnedCaloriesTodayLabel = app.staticTexts["Burned calories today."]

            XCTAssertTrue(burnedCaloriesTodayLabel.waitForExistence(timeout: 3))

            let xmarkButton = app.buttons["xmark"]
            xmarkButton.tap()

            XCTAssertTrue(burnedCaloriesTodayLabel.waitForNonExistence(timeout: 3))
        }
    }
    
    func test_CalatogueView_shouldOpenClimbedyView() {
        // Given
  
        // When
        let climbedCard = app.otherElements["Climbed"]

        XCTAssertTrue(climbedCard.waitForExistence(timeout: 3))
        climbedCard.tap()
        // Then
        let climbedStairsForTodayLabel = app.staticTexts["Your climbed stairs for today."]
        
        XCTAssertTrue(climbedStairsForTodayLabel.waitForExistence(timeout: 3))
        
    }
    
    func test_CalatogueView_shouldOpenClimbedyViewAndCloseUponXMarkTap() {
        // Given
        print(app.debugDescription)
        // When
        let climbedCard = app.otherElements["Climbed"]

        XCTAssertTrue(climbedCard.waitForExistence(timeout: 3))
        climbedCard.tap()
        // Then
        
        let climbedStairsForTodayLabel = app.staticTexts["Your climbed stairs for today."]
        
        XCTAssertTrue(climbedStairsForTodayLabel.waitForExistence(timeout: 3))
        
        let xmarkButton = app.buttons["xmark"]
        xmarkButton.tap()
        
        XCTAssertTrue(
            climbedStairsForTodayLabel.waitForNonExistence(timeout: 3)
        )
        
    }
    
    
    func test_CalatogueView_shouldOpenClimbedyViewAndCloseUponXMarkTapStress() {
        // Given
        print(app.debugDescription)
        // When
        
        for _ in 0..<5 {
            let climbedCard = app.otherElements["Climbed"]
            
            XCTAssertTrue(climbedCard.waitForExistence(timeout: 3))
            climbedCard.tap()
            // Then
            
            let climbedStairsForTodayLabel = app.staticTexts["Your climbed stairs for today."]
            
            XCTAssertTrue(climbedStairsForTodayLabel.waitForExistence(timeout: 3))
            
            let xmarkButton = app.buttons["xmark"]
            xmarkButton.tap()
            
            XCTAssertTrue(climbedStairsForTodayLabel.waitForNonExistence(timeout: 3))
        }
        
    }
    
 
}
