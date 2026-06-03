//
//  CaloriesView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct CaloriesView: View {
    @StateObject var caloriesVM: CaloriesViewModel
    
    init(manager: HKDataManagerProtocol) {
        _caloriesVM = StateObject(wrappedValue: CaloriesViewModel(manager: manager))
    }
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Calories")
                
                Text("\(caloriesVM.caloriesData?.latest ?? 0.0)")
            }
            
            
            .task {
                do {
                    try await caloriesVM.getCaloriesDataData()
                    
                } catch {}
            }
        }
    }
}

//#Preview {
//    CaloriesView()
//}
