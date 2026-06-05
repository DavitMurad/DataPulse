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
    let asd = 5...8
    @Published var weightdData: WeightModel?
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    var getLastWeight:ClosedRange<Int> {
        if let lastWeight = weightdData?.weight.last?.value {
            return Int(lastWeight - 5)...Int(lastWeight + 5)
        }
        return 0...0
    }
    
    var getLastBodyFat: ClosedRange<Int> {
        if let lastBF = weightdData?.bodyFat.last?.value {
            return Int(lastBF - 5)...Int(lastBF + 5)
        }
        return 0...0
    }
    
    var getDateDomain: ClosedRange<Date> {
        Calendar.current.date(byAdding: .day, value: -7, to: .now)! ... .now
    }
    
    func getWeightData() async throws {
        weightdData = try? await manager.getWeightData()
    }
    

}
