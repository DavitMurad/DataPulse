//
//  WeightViewModelTests.swift
//  DataPulseTests
//
//  Created by Davit Muradyan on 07.06.26.
//

import Foundation
import Testing
@testable import DataPulse


struct WeightViewModelTests {
    // Naming - test_[struct or class]_[variable or function]_[expected result]


   let manager = MockedHealthKitManager()
    
    @MainActor
    @Test func weightViewModel_weightData_isNil() {
        // Given
        let weightVM = WeightViewModel(manager: manager)
        // When
        // Then
        #expect(weightVM.weightdData == nil)
    }
    
    @MainActor
    @Test func weightViewModel_weightData_isNotNil() async throws {
        // Given
        let weightVM = WeightViewModel(manager: manager)
        // When
        try await weightVM.getWeightData()
        // Then
        #expect(weightVM.weightdData != nil)
    }
    
    
    @MainActor
    @Test func weightViewModel_weightData_isNilDueToAnError() async throws {
        // Given
        let manager = MockedHealthKitManager(weightResult: .failure(HealthKitSystemError.notAvailable))
        let weightVM = WeightViewModel(manager: manager)
        // When

        // Then
        await #expect(throws: HealthKitSystemError.notAvailable) {
             try await weightVM.getWeightData()
         }
        #expect(weightVM.weightdData == nil)
    }
    
    @MainActor
    @Test func weightViewModel_weightData_recivedEmptyData() async throws {
        // Given
        let manager = MockedHealthKitManager(weightResult: .success(WeightModel(weight: [], bodyFat: [], bmi: HealthDataPoint(date: .now, value: 0), weeklyAvgWeight: 0, weeklyAvgBF: 0)))
        let weightVM = WeightViewModel(manager: manager)
        // When
        try await weightVM.getWeightData()

        // Then
        let weightData = try #require(weightVM.weightdData)
        #expect(weightData.weight.isEmpty)
        #expect(weightData.bodyFat.isEmpty)
    }
    
    @MainActor
    @Test func weightViewModel_weightData_weightHasSevenElements() async throws {
        // Given
  
        let weightVM = WeightViewModel(manager: manager)
        // When
        try await weightVM.getWeightData()

        // Then
        let weightData = try #require(weightVM.weightdData)
        #expect(weightData.weight.count == 7)
    }
    
    @MainActor
    @Test func weightViewModel_weightData_bodyFatHasSevenElements() async throws {
        // Given
  
        let weightVM = WeightViewModel(manager: manager)
        // When
        try await weightVM.getWeightData()

        // Then
        let weightData = try #require(weightVM.weightdData)
        #expect(weightData.bodyFat.count == 7)
    }
    
    @MainActor
    @Test func weightViewModel_weightData_weeklyAvgBFCalculationIsCorrect() async throws {
        // Given
  
        let weightVM = WeightViewModel(manager: manager)
        // When
        try await weightVM.getWeightData()

        // Then
        let weightData = try #require(weightVM.weightdData)
        let formatted = (weightData.weeklyAvgBF * 10).rounded() / 10
        #expect(formatted == 13.2)
    }
    
    
    
}
