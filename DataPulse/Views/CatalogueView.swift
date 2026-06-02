//
//  CatalogueView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import HealthKit

struct CatalogueView: View {
    @StateObject var vm: StepsViewModel
    
    init(manager: DataManagerProtocol) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                vm.manager.requestAccess { isSuccess in
                    if isSuccess {
                        print("yes")
                    } else {
                        print("Not today")
                    }
                }
                do {
//                    await print(try vm.getCumulativeData(identifier: .stepCount).0)
//                    await print(try vm.getCumulativeData(identifier: .flightsClimbed).1)
//                    await print(vm.getWeightData()?.weight ?? [], vm.getWeightData()?.bodyFat ?? [],  vm.getWeightData()?.bmi ?? [] )
//                    await print(try vm.getCaloresData())
                    
                    print(try await vm.getStepsData())
                    print(try await vm.getClimbedData())
                    print(try await vm.getWeightData())
                    print(try await vm.getCaloresData())
                    
                } catch {}
            }
    }
}

#Preview {
    let manager = HealthKitManager()
    CatalogueView(manager: manager)
}
