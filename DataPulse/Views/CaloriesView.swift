//
//  CaloriesView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI

struct CaloriesView: View {
    @StateObject var vm: CaloriesViewModel
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: CaloriesViewModel(manager: manager))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                do {
                    print(try await vm.getCaloriesDataData())
                    
                    
                } catch {}
            }
    }
}

//#Preview {
//    CaloriesView()
//}
