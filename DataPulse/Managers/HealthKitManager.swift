//
//  HealthKitManager.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import HealthKit

class HealthKitManager: DataManagerProtocol {
    
    private var healthStore = HKHealthStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
              let weight = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let bodyFat = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
              let bmi = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let burnedCals = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        else { return }
        
        
        guard let sleep = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        let quantityTypes: [HKQuantityType] = [steps, weight, bodyFat, bmi, burnedCals]
        let categoryTypes: [HKCategoryType] = [sleep]
        
        let typesToRead: Set<HKObjectType> = Set(quantityTypes).union(categoryTypes)
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
    
    
    
    func getStepsData(startDate: Date, interval: DateComponents) async throws -> [Double] {
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount) else { throw URLError(.badURL) }
        
        // start - end
        // predicate
        // query
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsCollectionQuery(
                quantityType: steps,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: startDate,
                intervalComponents: interval
            )
            
            
            query.initialResultsHandler = { query, results, error in
                
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                var resultSteps: [Double] = []
                results?.enumerateStatistics(from: startDate, to: Date()) { stats, _ in
                    
                    let results = stats.sumQuantity()?.doubleValue(for: .count()) ?? 0
                    resultSteps.append(results)
                    print("Date: \(stats.startDate), Steps: \(steps)")
                }
                continuation.resume(returning: resultSteps)
                
            }
            healthStore.execute(query)
        }
    }
}
