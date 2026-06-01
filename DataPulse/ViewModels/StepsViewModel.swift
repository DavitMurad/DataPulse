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
    
    func getCumulativeData(identifier: HKQuantityTypeIdentifier ) async throws -> CumulativeDataProtocol {
        do {
            let monthly = try await manager.getCumulativeData(startDate: Date().addingTimeInterval(-2592000), interval: DateComponents(day: 1), identifier: identifier)
            
            let weekly = Array(monthly.suffix(7))
      
            return StepsModel(latest: weekly[weekly.count - 1], weeklyAvg: weekly.reduce(0, {($0 + $1) / Double(weekly.count)}), weekly: weekly, monthly: monthly)
            
        } catch {
           throw error
        }
    }
}
