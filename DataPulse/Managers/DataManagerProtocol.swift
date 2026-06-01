//
//  DataManagerProtocol.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import HealthKit

protocol DataManagerProtocol {
    func requestAccess(completion: @escaping (Bool) -> Void)
    func getCumulativeData(startDate: Date, interval: DateComponents, identifier: HKQuantityTypeIdentifier) async throws -> [Double]
    func getWeightData() async throws -> WeightModel
//    func getCaloriesData() -> CaloriesModel
//    func getSleepsData() -> SleepModel
}
