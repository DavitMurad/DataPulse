//
//  SleepModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation

struct ClimbedModel: CumulativeDataProtocol {
    let latest: Double
    let weeklyAvg: Double
    let weekly: [Double]
    let monthly: [Double]
}
