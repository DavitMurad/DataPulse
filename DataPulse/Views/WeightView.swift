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
        ZStack {
            Color.white
            VStack {
                Text("Weight")
                
                Text("\(vm.weightdData?.bodyFat.last?.value ?? 0.0)")
            }
            
            .task {
                do {
                    try await vm.getWeightData()
                } catch {}
            }
        }
    }
}

//#Preview {
//    WeightView()
//}
