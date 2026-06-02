//
//  CatalogueView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import HealthKit

struct CatalogueView: View {
    @StateObject var vm: StepsViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                vm.manager.requestAccess { isSuccess in
                    guard !isSuccess else { return }
                }
            }
    }
}

#Preview {
    let manager = HealthKitManager()
    CatalogueView(manager: manager)
}
