//
//  HealthDataPoint.swift
//  DataPulse
//
//  Created by Davit Muradyan on 03.06.26.
//

import Foundation

struct HealthDataPoint: Identifiable {
    let date: Date
    let value: Double
    
    let id = UUID().uuidString
}
