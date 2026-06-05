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
    @Published var calNote = """
        Small daily gains add up. Burning an extra 300–500 calories per day through walking, exercise, or staying active can contribute to improved cardiovascular health, increased energy expenditure, and long-term weight management.
        """
    @Published var recommendedNEAT = 300.0
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
    
    func getCaloriesDataData() async throws  {
        caloriesData = try? await manager.getCaloriesData()
    }
}
