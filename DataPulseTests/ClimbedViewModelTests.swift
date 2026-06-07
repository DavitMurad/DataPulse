//
//  ClimbedViewModelTests.swift
//  DataPulseTests
//
//  Created by Davit Muradyan on 07.06.26.
//

import Testing
@testable import DataPulse

struct ClimbedViewModelTests {
    // Naming - test_[struct or class]_[variable or function]_[expected result]
    
    let manager = MockedHealthKitManager()
    
    @MainActor
    @Test func climbedViewModel_climbedData_isNil() async {
        // Given
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        
        // Then
        #expect(climbedVM.climbedData == nil)
        
    }
    
    @MainActor
    @Test func climbedViewModel_climbedData_isNotNil() async throws {
        // Given
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        try await climbedVM.getClimbedData()
        
        // Then
        #expect(climbedVM.climbedData != nil)
    }
    
    @MainActor
    @Test func climbedViewModel_climbedData_isNilDueToAnError() async throws {
        // Given
        let manager = MockedHealthKitManager(climbedResult: .failure(HealthKitSystemError.notAvailable))
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
    
        // Then
        await #expect(throws: HealthKitSystemError.notAvailable) {
            try await climbedVM.getClimbedData()
        }
        #expect(climbedVM.climbedData == nil)
    }
    
    @MainActor
    @Test func climbedViewModel_climbedData_recivedEmptyData() async throws {
        // Given
        let manager = MockedHealthKitManager(climbedResult: .success(ClimbedModel(latest: 0, weeklyAvg: 0, weekly: [], monthly: [], monthlySum: 0, weeklySum: [])))
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        try await climbedVM.getClimbedData()
        
        // Then
        let climbedData = try #require(climbedVM.climbedData)
        
        #expect(climbedData.weekly.isEmpty)
        #expect(climbedData.monthly.isEmpty)
    }

    
    @MainActor
    @Test func climbedViewModel_climbedData_weeklyArrayHasSevenElements() async throws {
        // Given
      
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        try await climbedVM.getClimbedData()
        
        // Then
        let climbedData = try #require(climbedVM.climbedData)
        
        #expect(climbedData.weekly.count == 7)
    }
    
    @MainActor
    @Test func climbedViewModel_climbedData_isWeeklyAverageCalculatedCorrectly() async throws {
        // Given
      
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        try await climbedVM.getClimbedData()
        
        // Then
        let climbedData = try #require(climbedVM.climbedData)
        
        #expect(climbedData.weeklyAvg == 4.0)
    }
    
    @MainActor
    @Test func climbedViewModel_climbedData_isMonthlySumCalculatedCorrectly() async throws {
        // Given
      
        let climbedVM = ClimbedViewModel(manager: manager)
        
        // When
        try await climbedVM.getClimbedData()
        
        // Then
        let climbedData = try #require(climbedVM.climbedData)
        
        #expect(climbedData.monthlySum == 132.0)
    }

}
