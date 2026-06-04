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
    
    func getStepsData() async throws {
        if let stepData = try? await manager.getStepsdData() {
            self.stepData = stepData
        }
    }
}
