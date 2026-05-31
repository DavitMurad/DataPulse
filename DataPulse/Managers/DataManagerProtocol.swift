//
//  DataManagerProtocol.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation

protocol DataManagerProtocol {
    func requestAccess(completion: @escaping (Bool) -> Void)
    func getStepsData(startDate: Date, interval: DateComponents) async throws -> [Double]
//    func getWeightData() -> WeightModel
//    func getCaloriesData() -> CaloriesModel
//    func getSleepsData() -> SleepModel
}
