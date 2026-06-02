//
//  DataPulseApp.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

@main
struct DataPulseApp: App {
    let manager = MockedHealthKitManager()
    var body: some Scene {
        WindowGroup {
            CatalogueView(manager: manager)
        }
    }
}
