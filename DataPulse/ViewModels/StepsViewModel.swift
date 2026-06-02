//
//  StepsViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import Combine
import HealthKit

class StepsViewModel: ObservableObject {
    let manager: DataManagerProtocol
    
    init(manager: DataManagerProtocol) {
        self.manager = manager
    }
    
//    func getCumulativeData(identifier: HKQuantityTypeIdentifier ) async throws -> (CumulativeDataProtocol, CumulativeDataProtocol) {
//        // break this up
//        do {
//            let monthly = try await manager.getCumulativeData(startDate: Date().addingTimeInterval(-86400 * 30), interval: DateComponents(day: 1), identifier: identifier)
//            
//            let weekly = Array(monthly.suffix(7))
//      
//            return (StepsModel(latest: weekly.last ?? 0, weeklyAvg: weekly.reduce(0, {($0 + $1) / Double(weekly.count)}), weekly: weekly, monthly: monthly),
//                    ClimbedModel(latest: weekly.last ?? 0, weeklyAvg: weekly.reduce(0, {($0 + $1) / Double(weekly.count)}), weekly: weekly, monthly: monthly))
//            
//        } catch {
//           throw error
//        }
//    }
    
    func getStepsData() async throws -> StepsModel? {
        try? await manager.getStepsdData()
    }
    
    func getClimbedData() async throws -> ClimbedModel? {
        try? await manager.getClimbedData()
    }
    
    func getCaloresData() async throws -> CaloriesModel? {
        try? await manager.getCaloriesData()
    }
    
    func getWeightData() async -> WeightModel? {
        try? await manager.getWeightData()
    }
}
