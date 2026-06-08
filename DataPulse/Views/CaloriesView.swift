//
//  CaloriesView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct CaloriesView: View {
    @StateObject var caloriesVM: CaloriesViewModel
    var closeButtonPressed: () -> ()
    
    init(manager: HKDataManagerProtocol, closeButtonPressed: @escaping () -> ()) {
        _caloriesVM = StateObject(wrappedValue: CaloriesViewModel(manager: manager))
        self.closeButtonPressed = closeButtonPressed
    }
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                closeButton
                
                calsToday
                Divider()
                calsProgressView
                Divider()
                calsText
            }
            .padding()
        }
        .task {
            do {
                try await caloriesVM.getCaloriesDataData()
                
            } catch {}
        }
    }
}

#Preview {
    let manager = MockedHealthKitManager()
    CaloriesView(manager: manager) {
        
    }
}
