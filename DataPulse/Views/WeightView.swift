//
//  WeightView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import Charts

struct WeightView: View {
    @StateObject var weightVM: WeightViewModel
    let closeButtonPressed: () -> ()
    
    init(manager: HKDataManagerProtocol, closeButtonPressed: @escaping () -> () ) {
        _weightVM = StateObject(wrappedValue: WeightViewModel(manager: manager))
        self.closeButtonPressed = closeButtonPressed
        
    }
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                closeButton
                
                weightGraphView
                
                Divider()
                bfGraphView
                
                Divider()
                bmiBarView
            }
            .padding()
            
            .task {
                do {
                    try await weightVM.getWeightData()
                } catch {}
            }
        }
    }
}

#Preview {
    let manager = MockedHealthKitManager()
    WeightView(manager: manager) {
        
    }
}
