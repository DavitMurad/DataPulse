//
//  CaloriesViewModelTests.swift
//  DataPulseTests
//
//  Created by Davit Muradyan on 07.06.26.
//

import Testing
@testable import DataPulse

struct CaloriesViewModelTests {
    
    // Naming - test_[struct or class]_[variable or function]_[expected result]
    
    
    let manager = MockedHealthKitManager()
    
    @MainActor
    @Test func caloriesViewModel_caloreData_isNil() async {
        let caloriesVM = CaloriesViewModel(manager: manager)
        #expect(caloriesVM.caloriesData == nil)
    }
    
    @MainActor
    @Test func caloriesViewModel_caloreData_isNotNil() async throws {
        // Given
        let caloriesVM = CaloriesViewModel(manager: manager)
        // When
        try await caloriesVM.getCaloriesDataData()
        // Then
        #expect(caloriesVM.caloriesData != nil)
    }
    
    @MainActor
    @Test func caloriesViewModel_caloreData_isNilDueToAnError() async {
        // Given
        let manager = MockedHealthKitManager(caloriesResult: .failure(HealthKitSystemError.notAvailable))
        let caloriesVM = CaloriesViewModel(manager: manager)
        
        // When
        
        // Then
        await #expect(throws: HealthKitSystemError.notAvailable) {
            try await caloriesVM.getCaloriesDataData()

        }
        #expect(caloriesVM.caloriesData == nil)
    }
    
    @MainActor
    @Test func caloriesViewModel_caloreData_recievedEmptyData() async throws {
        // Given
        let manager = MockedHealthKitManager(caloriesResult: .success(CaloriesModel(weeklyCaloriesBurned: [], latest: 0)))
        let caloriesVM = CaloriesViewModel(manager: manager)
        // When
        try await caloriesVM.getCaloriesDataData()
        // Then
        
        let caloriesData = try #require(caloriesVM.caloriesData)

        #expect(caloriesData.weeklyCaloriesBurned.isEmpty)
        #expect(caloriesData.latest == 0)
    }
    
    @MainActor
    @Test func caloriesViewModel_caloreData_weeklyCaloriesBurnedHasSevenElements() async throws {
        // Given
        let caloriesVM = CaloriesViewModel(manager: manager)
        // When
        try await caloriesVM.getCaloriesDataData()
        // Then
        let caloriesData = try #require(caloriesVM.caloriesData)

        #expect(caloriesData.weeklyCaloriesBurned.count == 7)
    }
    
    @MainActor
    @Test func caloriesViewModel_caloreData_lastestCalorieBurnedCalculatedCorrectly() async throws {
        // Given
        let caloriesVM = CaloriesViewModel(manager: manager)
        // When
        try await caloriesVM.getCaloriesDataData()
        // Then
        let caloriesData = try #require(caloriesVM.caloriesData)

        #expect(caloriesData.latest == 203.5)
    }
    
    
    
}


