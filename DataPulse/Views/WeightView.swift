//
//  WeightView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct WeightView: View {
    @StateObject var vm: WeightViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: WeightViewModel(manager: manager))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                do {
                    print(try await vm.getWeightData())
                } catch {}
            }
    }
}

//#Preview {
//    WeightView()
//}
