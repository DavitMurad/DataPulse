# About 🤌
An excuse to tie together Dependency Injection, Unit Testing and UI Testing all in one place, while pulling real health data from HealthKit or, well, mocking it. 

https://github.com/user-attachments/assets/499246f3-cec9-4925-9f88-5e4d7df9f6c9

# Device Screenshots (HealthKit Data, yes the actual data)
***Some categories contain limited data due to device usage patterns.***


<table>
  <tr>
    <td><img width="200" src="https://github.com/user-attachments/assets/90e9bf0b-1524-40ad-9dfc-acc90bd32ded"></td>
    <td><img width="200" src="https://github.com/user-attachments/assets/3ef205f9-a73a-49a1-b3bf-5acfa931117f"/></td>
    <td><img width="200" src="https://github.com/user-attachments/assets/b05d6171-65f4-4123-8a01-8f0d5485946e"/></td>
    <td><img width="200" src="https://github.com/user-attachments/assets/2548401c-c855-4744-b0b4-a2c94eb0fcec"/></td>
    <td><img width="200" src="https://github.com/user-attachments/assets/49a904b8-6227-46a8-bce9-518bd65ce23d"/></td>
  </tr>
</table>

# Technologies Used
- **SwiftUI** - entire app is built natively
- **Swift Testing & XCTest/XCUI** - unit and UI test coverage throughout
- **HealthKit** - real health and fitness data extraction
- **Swift Charts** - multiple chart types chosen to match each data type
- **Swift Concurrency (async/await)** - clean async HealthKit queries without callback chaos

## Example Unit & UI Tests
- Unit Test example:
``` swift
   @MainActor
    @Test func stepsViewModel_whenReceivingEmptyData_shouldReturnEmptyCollections() async throws {
        // Given
        let manager = MockedHealthKitManager(stepResult: .success(StepsModel.init(latest: 0, weeklyAvg: 0, weekly: [], monthly: [], monthlySum: 0, weeklySum: [])))
        let stepVM = StepsViewModel(manager: manager)
        
        // When
        try await stepVM.getStepsData()
        
        // Then
        let stepData = try #require(stepVM.stepData)
        
        #expect(stepData.weekly.isEmpty)
        #expect(stepData.monthly.isEmpty)
    }
```
- UI Test example: 
``` swift
   func test_CatalogueView_shouldOpenStepViewAndCloseUponXMarkTapStress() {

        for _ in 0..<5 {
            let stepstCard = app.otherElements["Steps"]
            
            XCTAssertTrue(stepstCard.waitForExistence(timeout: 3))
            stepstCard.tap()
            
            let stepsForTodayLabel = app.staticTexts["Your steps for today."]
            
            XCTAssertTrue(stepsForTodayLabel.waitForExistence(timeout: 3))
            
            let xmarkButton = app.buttons["xmark"]
            xmarkButton.tap()
            
            XCTAssertTrue(stepsForTodayLabel.waitForNonExistence(timeout: 3))
        }
    }
```

# Highlights
- **Protocol-based DI** - real and mocked data managers are fully interchangeable
- **matchedGeometryEffect** - cards expand into full detail views with a single shared namespace, no navigation stack needed
- **Chart variety** - bar, line, donut, ring progress, and a BMI slider, each chosen for what the data actually communicates
- **Configurable mock via Result injection** - one MockedHealthKitManager covers happy path, empty data, and error scenarios without multiple classes
- **withCheckedThrowingContinuation** - bridging HealthKit's callback-based queries into async/await properly

# Challenges & Learnings
- HealthKit's query API is callback-based under the hood, wrapping it cleanly in async/await took more thought than expected
- Swift Charts axis customisation is deceptively nuanced, chartXAxis, AxisMarks, and scale padding all interact in non-obvious ways
- Writing tests that actually catch bugs rather than just confirming the code runs, learned the difference the hard way
- A tad constrianted with not many navigation and interaction patterns to test, I really wanted to struggle on unit tests

# Reflection
One of my strongest portfolio pieces, combining system APIs, data visualisation, and testable architecture. It all held up.
HealthKit and Swift Charts have a lot more to give - different categories with seperate extraction techniques and interactions patterns respectively.

Thanks for stopping by. 

Still exploring Apple's ecosystem. 

Cheers ✌️
