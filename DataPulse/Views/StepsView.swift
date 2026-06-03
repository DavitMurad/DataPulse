//
//  StepsView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import Charts

struct StepsView: View {
    @StateObject var vm: StepsViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
        
    }
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Steps")
                Text("\(vm.stepData?.latest ?? 0.0)")
                
                Chart {
                    if let stepData = vm.stepData {
                        ForEach(stepData.weekly) { data in
                            BarMark(
                                x: .value("Day", data.date),
                                y: .value("Steps", data.value)
                            )
                            
                        }
                    }
                    
                }
                .frame(height: 300)
                .padding()
            }
            
            .task {
                do {
                    try await vm.getStepsData()
                    
                    
                } catch {}
            }
        }
    }
}

//#Preview {
//    StepsView()
//}
