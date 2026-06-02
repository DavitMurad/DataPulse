//
//  StepsViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation
import Combine
import HealthKit

@MainActor
class StepsViewModel: ObservableObject {
    let manager: HKDataManagerProtocol
    
    @Published var stepData: StepsModel?

    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getStepsData() async throws -> StepsModel? {
        stepData = try? await manager.getStepsdData()
        return stepData
    }
    
//    func getClimbedData() async throws -> ClimbedModel? {
//        try? await manager.getClimbedData()
//    }
//    
//    func getCaloresData() async throws -> CaloriesModel? {
//        try? await manager.getCaloriesData()
//    }
//    
//    func getWeightData() async -> WeightModel? {
//        try? await manager.getWeightData()
//    }
}
