//
//  SleepModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation

struct ClimbedModel {
    let latest: Double
    let weeklyAvg: Double
    let weekly: [HealthDataPoint]
    let monthly: [HealthDataPoint]
}
