//
//  ClimbedViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 02.06.26.
//

import Foundation
import Combine

@MainActor
class ClimbedViewModel: ObservableObject {
    let manager: HKDataManagerProtocol
    @Published var climbedData: ClimbedModel?
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getClimbedData() async throws -> ClimbedModel? {
        climbedData = try? await manager.getClimbedData()
        return climbedData
    }
}
