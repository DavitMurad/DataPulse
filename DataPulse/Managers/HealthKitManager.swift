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

class HealthKitManager: HKDataManagerProtocol {
    
    
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
    
    func getStepsdData() async throws -> StepsModel {
        do {
            let monthly = try await getHKData(identifier: .stepCount, unit: .count(), options: .cumulativeSum, startFrom: 30)
            let weekly = Array(monthly.suffix(7))
            
            let weeklyAvg = weekly.reduce(0, {$0 + $1.value}) / Double(weekly.count)
            
            return StepsModel(latest: weekly.last?.value ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly)
            
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
    
    func getClimbedData() async throws -> ClimbedModel {
        do {
            let monthly = try await getHKData(identifier: .flightsClimbed, unit: .count(), options: .cumulativeSum, startFrom: 30)
            let weekly = Array(monthly.suffix(7))
            let weeklyAvg = weekly.reduce(0, {$0 + $1.value}) / Double(weekly.count)
    
            return ClimbedModel(latest: weekly.last?.value ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly)
            
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
    
    func getWeightData() async throws -> WeightModel {
        do {
            let weight = try await getHKData(identifier: .bodyMass, unit: .gramUnit(with: .kilo), options: .mostRecent, startFrom: 6)
            let bodyFat = try await getHKData(identifier: .bodyFatPercentage, unit: .percent(), options: .mostRecent, startFrom: 6).map { HealthDataPoint(date: $0.date, value: $0.value * 100) }
            let bmi = try await getHKData(identifier: .bodyMassIndex, unit: .count(), options: .mostRecent, startFrom: 6)
            
            return WeightModel(weight: weight, bodyFat: bodyFat, bmi: bmi)
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
    
    func getCaloriesData() async throws -> CaloriesModel {
        do {
            let burnedCalories = try await getHKData(identifier: .activeEnergyBurned, unit: .kilocalorie(), options: .cumulativeSum, startFrom: 6)
            return CaloriesModel(weeklyCaloriesBurned: burnedCalories, latest: burnedCalories.last?.value ?? 0)
        } catch {
            throw HealthKitSystemError.notAvailable
        }
    }
}

