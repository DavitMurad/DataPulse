//
//  WeightViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 02.06.26.
//

import Foundation
import Combine

@MainActor
class WeightViewModel: ObservableObject {
    let manager: HKDataManagerProtocol
    @Published var weightdData: WeightModel?
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getWeightData() async throws -> WeightModel? {
        weightdData = try? await manager.getWeightData()
        return weightdData
    }
}
