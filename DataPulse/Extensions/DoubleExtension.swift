//
//  DoubleExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 06.06.26.
//

import Foundation

extension Double {
    var kFormat: String {
        switch self {
        case 1_000..<1_000_000:
            return String(format: "%.0fK", self / 1_000)
        case 1_000_000...:
            return String(format: "%.0fM", self / 1_000_000)
        default:
            return String(format: "%.0f", self)
        }
    }
}
