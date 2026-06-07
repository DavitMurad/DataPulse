//
//  SleepView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import Charts

struct ClimbView: View {
    @StateObject var climbedVM: ClimbedViewModel
    
    var closeButtonPressed: () -> ()
    
    init(manager: HKDataManagerProtocol, closeButtonPressed: @escaping () -> ()) {
        _climbedVM = StateObject(wrappedValue: ClimbedViewModel(manager: manager))
        self.closeButtonPressed = closeButtonPressed
        
    }
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                backButtonView
                
                climbedTodayView
                
                Divider()
                
                weeklyClimbedBarView
                
                Divider()
                
                monthlyDistributionAcrossWeekView
            }
            .padding()
            
            .task {
                do {
                    try await climbedVM.getClimbedData()
                } catch {}
            }
        }
    }
}

#Preview {
    let manager = MockedHealthKitManager()
    ClimbView(manager: manager) {
        
    }
}
