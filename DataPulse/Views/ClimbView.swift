//
//  SleepView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct ClimbView: View {
    @StateObject var vm: ClimbedViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: ClimbedViewModel(manager: manager))
    }
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Climbed")
                Text("\(vm.climbedData?.latest ?? 0.0)")
            }
            .task {
                do {
                    try await vm.getClimbedData()
                } catch {}
            }
        }
    }
}

//#Preview {
//    ClimbView()
//}
