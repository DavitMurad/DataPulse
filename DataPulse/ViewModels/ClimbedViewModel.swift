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
    
    var yAxisScale: ClosedRange<Date> {
        Calendar.current.date(byAdding: .day, value: -6, to: .now)! ... .now
    }
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getClimbedData() async throws {
        climbedData = try await manager.getClimbedData()
    }
}
