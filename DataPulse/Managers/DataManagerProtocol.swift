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
//    func getCumulativeData(startDate: Date, interval: DateComponents, identifier: HKQuantityTypeIdentifier) async throws -> [Double]
    func getStepsdData() async throws -> StepsModel
    func getClimbedData() async throws -> ClimbedModel
    func getWeightData() async throws -> WeightModel
    func getCaloriesData() async throws -> CaloriesModel
}
