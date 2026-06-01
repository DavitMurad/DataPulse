//
//  StepsModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import Foundation

protocol CumulativeDataProtocol {
    var latest: Double { get }
    var weeklyAvg: Double { get }
    var weekly: [Double] { get }
    var monthly: [Double] { get }
}

struct StepsModel: CumulativeDataProtocol {
    let latest: Double
    let weeklyAvg: Double
    let weekly: [Double]
    let monthly: [Double]
}
