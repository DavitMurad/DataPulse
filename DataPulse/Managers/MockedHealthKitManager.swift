//
//  MockedHealthKitManager.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import HealthKit

class MockedHealthKitManager: HKDataManagerProtocol  {
    func requestAccess(completion: @escaping (Bool) -> Void) {
        
    }
     func getStepsdData() async throws -> StepsModel {
         
         let monthly = [7345.0, 8123.0, 6789.0, 8542.0, 7921.0, 8854.0, 7432.0, 8210.0, 7987.0, 9134.0, 7564.0, 8345.0, 7890.0, 8678.0, 7234.0, 8012.0, 8456.0, 7765.0, 8923.0, 7489.0, 8234.0, 8056.0, 7698.0, 8876.0, 7345.0, 8452.0, 7621.0, 8934.0, 7788.0, 8245.0, 7094.0, 8124.0].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 31, to: .now)!, value: $0.element) }
         
         let monthlySum = monthly.reduce(0, {$0 + $1.value})

         
         let weekly = [8452.0, 7621.0, 8934.0, 7788.0, 8245.0, 7094.0, 8124.0].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }
         
         let weeklyAvg = weekly.reduce(0, { $0 + $1.value }) / Double(weekly.count)
         
         let monthlyWeeklyAverages = [7850.0, 8250.0, 7980.0, 8090.0, 8010.0].enumerated().map {HealthDataPoint(date: Calendar.current.date(byAdding: .weekOfYear, value: $0.offset - 4, to: .now)!, value: $0.element) }
         
         var weeklySum: [HealthDataPoint] = []

         for start in stride(from: 0, to: monthly.count, by: 7) {
             let end = min(start + 7, monthly.count)
             weeklySum.append(HealthDataPoint(date: monthly[end - 1].date, value: monthly[start..<end].reduce(0, {$0 + $1.value})))
         }
         
         return StepsModel(latest: weekly.last?.value ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly, monthlySum: monthlySum, weeklySum: weeklySum)

     }
     
     func getClimbedData() async throws -> ClimbedModel {
         
         let monthly = [3.0, 5.0, 4.0, 2.0, 6.0, 4.0, 5.0, 3.0, 7.0, 4.0, 2.0, 5.0, 4.0, 6.0, 3.0, 5.0, 4.0, 2.0, 5.0, 7.0, 3.0, 4.0, 6.0, 5.0, 4.0, 3.0, 6.0, 2.0, 5.0, 4.0, 4.0].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 30, to: .now)!, value: $0.element) }
         
         let monthlySum = monthly.reduce(0, {$0 + $1.value})
         
         let weekly = [3.0, 6.0, 2.0, 5.0, 4.0, 4.0, 4.0].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }
         
         let weeklyAvg = weekly.reduce(0, { $0 + $1.value }) / Double(weekly.count)
         var weeklySum: [HealthDataPoint] = []

         for start in stride(from: 0, to: monthly.count, by: 7) {
             let end = min(start + 7, monthly.count)
             weeklySum.append(HealthDataPoint(date: monthly[end - 1].date, value: monthly[start..<end].reduce(0, {$0 + $1.value})))
         }
         
         return ClimbedModel(latest: weekly.last?.value ?? 0, weeklyAvg: weeklyAvg, weekly: weekly, monthly: monthly, monthlySum: monthlySum, weeklySum: weeklySum)
     }
     
     func getWeightData() async throws -> WeightModel {
         
         let weight = [71.8, 71.7, 71.9, 71.6, 71.5, 71.7, 71.4].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }
         
         let weeklyAvgWeight = weight.reduce(0, { $0 + $1.value }) / Double(weight.count)
         
         let bodyFat = [13.3, 13.2, 13.4, 13.1, 13.2, 13.0, 13.1].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }
         
         let weeklyAvgBF = bodyFat.reduce(0, { $0 + $1.value }) / Double(bodyFat.count)
         
         let bmi = [24.85, 24.82, 24.89, 24.78, 24.75, 24.81, 24.71].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }.last ?? HealthDataPoint(date: Date(), value: 0)
         
         return WeightModel(weight: weight, bodyFat: bodyFat, bmi: bmi, weeklyAvgWeight: weeklyAvgWeight, weeklyAvgBF: weeklyAvgBF)
     }
     
     func getCaloriesData() async throws -> CaloriesModel {
         
         let weeklyCaloriesBurned = [212.4, 189.7, 225.8, 248.3, 181.9, 341.9, 203.5].enumerated().map { HealthDataPoint(date: Calendar.current.date(byAdding: .day, value: $0.offset - 6, to: .now)!, value: $0.element) }
         
         return CaloriesModel(weeklyCaloriesBurned: weeklyCaloriesBurned, latest: weeklyCaloriesBurned.last?.value ?? 0)
     }
 }
