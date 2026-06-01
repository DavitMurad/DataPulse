//
//  HealthKitManagerExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 01.06.26.
//

import Foundation
import HealthKit

extension HealthKitManager {
    func getWeightRelatedData(identifier: HKQuantityTypeIdentifier, unit: HKUnit) async throws -> [Double] {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else { throw HealthKitSystemError.systemError }
        
        let interval = DateComponents(day: 1)
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: Date())
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            throw HealthKitSystemError.notAvailable
        }
        guard let endOfWeek = calendar.date(byAdding: .day, value: -6, to: startOfWeek) else {
            throw HealthKitSystemError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfWeek,
            end: endOfWeek,
            options: .strictStartDate
        )
        
        return try await withCheckedThrowingContinuation { continuation in
            
            let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .mostRecent, anchorDate: startOfWeek, intervalComponents: interval)
            
            query.initialResultsHandler = {_, result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                var resultQuantity: [Double] = []
                result?.enumerateStatistics(from: startOfWeek, to: endOfWeek) { stats, _ in
                    let value = stats.mostRecentQuantity()?.doubleValue(for: unit) ?? 0
                    resultQuantity.append(value)
                }
                continuation.resume(returning: resultQuantity)
            }
            healthStore.execute(query)
        }
    }
}

//let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
