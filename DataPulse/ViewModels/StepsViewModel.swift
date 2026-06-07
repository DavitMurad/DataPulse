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
        stepData = try await manager.getStepsdData()
        
    }
    
    
    var XAxisScale: ClosedRange<Date> {
        Calendar.current.date(byAdding: .day, value: -7, to: .now)! ... .now
    }
}
