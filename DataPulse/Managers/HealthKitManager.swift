//
//  HealthKitManager.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import HealthKit

enum HealthKitSystemError: Error {
    case systemError
    case notAvailable
}

class HealthKitManager: DataManagerProtocol {
    
    private var healthStore = HKHealthStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
              let weight = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let bodyFat = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
              let bmi = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let burnedCals = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let climbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed)
        else { return }
        
        
//        guard let sleep = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let quantityTypes: [HKQuantityType] = [steps, weight, bodyFat, bmi, burnedCals, climbed]
//        let categoryTypes: [HKCategoryType] = [sleep]
        
//        let typesToRead: Set<HKObjectType> = Set(quantityTypes).union(categoryTypes)
        let typesToRead: Set<HKObjectType> = Set(quantityTypes)
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
    
    
    // Steps & CLimbed
    func getCumulativeData(startDate: Date, interval: DateComponents, identifier: HKQuantityTypeIdentifier) async throws -> [Double] {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else { throw HealthKitSystemError.systemError }
        
        // start - end
        // predicate
        // query
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        return try await withCheckedThrowingContinuation { continuation in
            
            let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startDate, intervalComponents: interval)
            
            query.initialResultsHandler = { query, results, error in
                
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                var resultQuantity: [Double] = []
                results?.enumerateStatistics(from: startDate, to: Date()) { stats, _ in
                    
                    let results = stats.sumQuantity()?.doubleValue(for: .count()) ?? 0
                    resultQuantity.append(results)
                }
                continuation.resume(returning: resultQuantity)
                
            }
            healthStore.execute(query)
        }
    }
    
}
