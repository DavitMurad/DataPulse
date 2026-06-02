//
//  StepsView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct StepsView: View {
    @StateObject var vm: StepsViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                do {
                    print(try await vm.getStepsData())

                    
                } catch {}
            }
    }
}

#Preview {
    StepsView()
}
