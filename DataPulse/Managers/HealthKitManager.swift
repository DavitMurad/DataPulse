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
    
    
    var healthStore = HKHealthStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
              let weight = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let bodyFat = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
              let bmi = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let burnedCals = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let climbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed)
        else { return }
        
        let quantityTypes: [HKQuantityType] = [steps, weight, bodyFat, bmi, burnedCals, climbed]
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
//    func getCumulativeData(startDate: Date, interval: DateComponents, identifier: HKQuantityTypeIdentifier) async throws -> [Double] {
//        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else { throw HealthKitSystemError.systemError }
//        
//        let interval = DateComponents(day: 1)
//        let calendar = Calendar.current
//        
//        let dayStart = calendar.startOfDay(for: Date())
//        
//        guard let startOfWeek = calendar.date(byAdding: .day, value: -30, to: dayStart),
//              let endOfWeek = calendar.date(byAdding: .day, value: 1, to: dayStart) else {
//            throw HealthKitSystemError.notAvailable
//        }
//        
//        let predicate = HKQuery.predicateForSamples(withStart: startOfWeek, end: endOfWeek, options: .strictStartDate)
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            
//            let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startOfWeek, intervalComponents: interval)
//            
//            query.initialResultsHandler = {_, result, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                var resultQuantity: [Double] = []
//                result?.enumerateStatistics(from: startDate, to: Date()) { stats, _ in
//                    
//                    let results = stats.sumQuantity()?.doubleValue(for: .count()) ?? 0
//                    resultQuantity.append(results)
//                    print(stats.startDate.formatted(), stats.endDate.formatted())
//                }
//                continuation.resume(returning: resultQuantity)
//                
//            }
//            healthStore.execute(query)
//        }
//    }
    
    func getStepsdData() async throws -> StepsModel {
        do {
            let monthly = try await getWeightRelatedData(identifier: .stepCount, unit: .count(), options: .cumulativeSum, startFrom: 30)
            let weekly = Array(monthly.suffix(7))
            let weeklyAvg = weekly.reduce(0, {$0 + $1}) / Double(weekly.count)
            
            return StepsModel(latest: weekly.last ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly)
            
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
    
    func getClimbedData() async throws -> ClimbedModel {
        do {
            let monthly = try await getWeightRelatedData(identifier: .flightsClimbed, unit: .count(), options: .cumulativeSum, startFrom: 30)
            let weekly = Array(monthly.suffix(7))
            let weeklyAvg = weekly.reduce(0, {$0 + $1}) / Double(weekly.count)
    
            return ClimbedModel(latest: weekly.last ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly)
            
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
    
    func getWeightData() async throws -> WeightModel {
        do {
            
            let weight = try await getWeightRelatedData(identifier: .bodyMass, unit: .gramUnit(with: .kilo), options: .mostRecent, startFrom: 6)
            let bodyFat = try await getWeightRelatedData(identifier: .bodyFatPercentage, unit: .percent(), options: .mostRecent, startFrom: 6).map { $0 * 100 }
            let bmi = try await getWeightRelatedData(identifier: .bodyMassIndex, unit: .count(), options: .mostRecent, startFrom: 6)
            
            return WeightModel(weight: weight, bodyFat: bodyFat, bmi: bmi)
        } catch {
            throw HealthKitSystemError.notAvailable
        }
        
    }
    
    func getCaloriesData() async throws -> CaloriesModel {
        do {
            let burnedCalories = try await getWeightRelatedData(identifier: .activeEnergyBurned, unit: .kilocalorie(), options: .cumulativeSum, startFrom: 6)
            return CaloriesModel(weeklyCaloriesBurned: burnedCalories, latest: burnedCalories.last!)
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
}

