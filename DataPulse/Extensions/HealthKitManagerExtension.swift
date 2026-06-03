//
//  HealthKitManagerExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 01.06.26.
//

import Foundation
import HealthKit

extension HealthKitManager {
    func getHKData(identifier: HKQuantityTypeIdentifier, unit: HKUnit, options: HKStatisticsOptions, startFrom: Int) async throws -> [HealthDataPoint] {
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
                var resultQuantity: [HealthDataPoint] = []
                result?.enumerateStatistics(from: startOfWeek, to: dayStart) { stats, _ in
                    switch options {
                    case .cumulativeSum:
                        print(stats.startDate.formatted(date: .abbreviated, time: .omitted))
                        print("''''''''''")
                        print(stats.endDate.formatted(date: .abbreviated, time: .omitted))
                        let endDate = stats.endDate.formatted(date: .abbreviated, time: .omitted)
                        let sumQuantity = stats.sumQuantity()?.doubleValue(for: unit) ?? 0
                        resultQuantity.append(HealthDataPoint(date: stats.endDate, value: sumQuantity))
                        
                        
                    case .mostRecent:
                        print(stats.startDate.formatted(date: .abbreviated, time: .omitted))
                        print("''''''''''")
                        print(stats.endDate.formatted(date: .abbreviated, time: .omitted))
                        let endDate = stats.endDate.formatted(date: .abbreviated, time: .omitted)
                        let sumQuantity = stats.sumQuantity()?.doubleValue(for: unit) ?? 0
                        resultQuantity.append(HealthDataPoint(date: stats.endDate, value: sumQuantity))
                        
                    default:
                        resultQuantity.append(HealthDataPoint(date: .now, value: 0.0))
                    }
                }
                continuation.resume(returning: resultQuantity)
            }
            healthStore.execute(query)
        }
    }
}
