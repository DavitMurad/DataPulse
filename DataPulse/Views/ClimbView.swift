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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                do {
                    print(try await vm.getClimbedData())
                    
                } catch {}
            }
    }
}

//#Preview {
//    ClimbView()
//}
