//
//  StepsView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import Charts

struct SalesData: Identifiable {
    let id = UUID()
    let month: String
    let sales: Int
}

let salesData = [
    SalesData(month: "Jan", sales: 200),
    SalesData(month: "Feb", sales: 150),
    SalesData(month: "Mar", sales: 180),
]



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
                    ForEach(salesData) { data in
                        BarMark(
                            x: .value("Month", data.month),
                            y: .value("Sales", data.sales)
                        )
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
