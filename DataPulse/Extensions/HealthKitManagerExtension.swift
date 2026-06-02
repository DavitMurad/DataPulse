//
//  HealthKitManagerExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 01.06.26.
//

import Foundation
import HealthKit

extension HealthKitManager {
    func getWeightRelatedData(identifier: HKQuantityTypeIdentifier, unit: HKUnit, options: HKStatisticsOptions, startFrom: Int) async throws -> [Double] {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else { throw HealthKitSystemError.systemError }
        
        let interval = DateComponents(day: 1)
        let calendar = Calendar.current
        
        let dayStart = calendar.startOfDay(for: Date())
        
        guard let startOfWeek = calendar.date(byAdding: .day, value: -startFrom, to: dayStart),
              let endOfWeek = calendar.date(byAdding: .day, value: 1, to: dayStart) else {
            throw HealthKitSystemError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfWeek, end: endOfWeek, options: .strictStartDate)
        
        return try await withCheckedThrowingContinuation { continuation in
            
            let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: options, anchorDate: startOfWeek, intervalComponents: interval)
            
            query.initialResultsHandler = {_, result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                var resultQuantity: [Double] = []
                result?.enumerateStatistics(from: startOfWeek, to: dayStart) { stats, _ in
                    switch options {
                    case .cumulativeSum:
                        resultQuantity.append(stats.sumQuantity()?.doubleValue(for: unit) ?? 0)
                        
                    case .mostRecent:
                        resultQuantity.append(stats.mostRecentQuantity()?.doubleValue(for: unit) ?? 0)
                        
                    default:
                        resultQuantity.append(0)
                    }
                }
                continuation.resume(returning: resultQuantity)
            }
            healthStore.execute(query)
        }
    }
}
