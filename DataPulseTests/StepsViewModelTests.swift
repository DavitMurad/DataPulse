//
//  DataPulseTests.swift
//  DataPulseTests
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import Testing
@testable import DataPulse


struct StepsViewModelTests {
    // Naming - test_[struct or class]_[variable or function]_[expected result]
    
    let manager = MockedHealthKitManager()
    
    
    @MainActor
    @Test func stepsViewModel_stepData_isNil() async {
        // Given
//        let manager = MockedHealthKitManager()
        let stepVM = StepsViewModel(manager: manager)
        
        // Then
        #expect(stepVM.stepData == nil)
    }
    
    
    @MainActor
    @Test func stepsViewModel_stepData_isNotNil() async throws {
        // Given
//        let manager = MockedHealthKitManager()
        let stepVM = StepsViewModel(manager: manager)
        // When
        try await stepVM.getStepsData()
        // Then
        #expect(stepVM.stepData != nil)
    }
    
    @MainActor
    @Test func stepsViewModel_stepData_isNilDueToAnError() async throws {
        // Given
        let manager = MockedHealthKitManager(stepResult: .failure(HealthKitSystemError.notAvailable))
        let stepVM = StepsViewModel(manager: manager)
        // When
   
        // Then
        await #expect(throws: HealthKitSystemError.notAvailable) {
             try await stepVM.getStepsData()

         }
        #expect(stepVM.stepData == nil)
    }
    
    @MainActor
    @Test func stepsViewModel_stepData_recivedEmptyData() async throws {
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
    
    @MainActor
    @Test func stepsViewModel_stepData_weeklyArrayHasSevenElements() async throws {
        // Given
//        let manager = MockedHealthKitManager()
        let stepVM = StepsViewModel(manager: manager)
        
        // When
        try await stepVM.getStepsData()
        
        // Then
        let stepData = try #require(stepVM.stepData)
        
        #expect(stepData.weekly.count == 7)
    }
    
    @MainActor
    @Test func stepsViewModel_stepData_latestisExtractedCorrectly() async throws {
        // Given
//        let manager = MockedHealthKitManager()
        let stepVM = StepsViewModel(manager: manager)
        
        // When
        try await stepVM.getStepsData()
        
        // Then
        let stepData = try #require(stepVM.stepData)
        #expect(stepData.latest == 8124.0)
    }
    
    @MainActor
    @Test func stepsViewModel_stepData_isWeeklyAverageCalculatedCorrectly() async throws {
        // Given
//        let manager = MockedHealthKitManager()
        let stepVM = StepsViewModel(manager: manager)
        
        // When
        try await stepVM.getStepsData()
        
        // Then
        let stepData = try #require(stepVM.stepData)
        let weeklyAvg = stepData.weekly.reduce(0, { $0 + $1.value }) / Double(stepData.weekly.count)
        let formatedWeeklyAvg = (weeklyAvg * 10).rounded() / 10
        #expect(formatedWeeklyAvg == 8036.9)
    }
}
