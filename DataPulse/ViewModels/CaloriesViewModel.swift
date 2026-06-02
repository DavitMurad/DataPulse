//
//  CaloriesViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 02.06.26.
//

import Foundation
import Combine

@MainActor
class CaloriesViewModel: ObservableObject {
    let manager: HKDataManagerProtocol
    @Published var caloriesData: CaloriesModel?
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getCaloriesDataData() async throws -> CaloriesModel? {
        caloriesData = try? await manager.getCaloriesData()
        return caloriesData
    }
}
