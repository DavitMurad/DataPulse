//
//  StepsView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct StepsView: View {
    @StateObject var vm: StepsViewModel
    
    var closeButtonPressed: () -> ()
    
    init(manager: HKDataManagerProtocol, closeButtonPressed: @escaping () -> () ) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
        self.closeButtonPressed = closeButtonPressed
        
    }
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                closeButtonView

                stepsForTodayView

                Divider()
                barChartView
              
                Divider()
                pieChartView
                
            }
            .padding()
            
            .task {
                do {
                    try await vm.getStepsData()
                } catch {}
            }
        }
    }
}

#Preview {
    let manager = MockedHealthKitManager()
    StepsView(manager: manager) {
        print("asd")
    }
}
