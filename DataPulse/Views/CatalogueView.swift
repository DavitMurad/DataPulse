//
//  CatalogueView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import HealthKit

//struct CustomVGrid<Content: View>: View {
//    var content: Content
//
//    init(_ content: () -> Content) {
//        self.content = content()
//    }
//    var body: some View {
//        VStack(spacing: 50) {
//            content
//        }
//    }
//}

struct CatalogueView: View {
    @StateObject var vm: StepsViewModel
    @Namespace var nameSpace
    @State private var isExpanded = false
    
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 50) {
                        HStack(spacing: 50) {
                            HKCategoryView(color: .blue, systemImageName: "shoeprints.fill", title: "Steps", rotationDegree: 0)
                                .matchedGeometryEffect(id: "123", in: nameSpace)
                                .frame(width: 150, height: 150)

                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        isExpanded.toggle()
                                    }
                                }
                            HKCategoryView(color: .pink, systemImageName: "scalemass", title: "Weight", rotationDegree: 0)
                            
                        }
                        HStack(spacing: 50)  {
                            HKCategoryView(color: .green, systemImageName: "flame.fill", title: "Calories", rotationDegree: 45)
                            HKCategoryView(color: .orange, systemImageName: "figure.stairs", title: "Climbed", rotationDegree: 0)
                            
                        }
                    }
                    if isExpanded {
                        RoundedRectangle(cornerRadius: 15)
                            .matchedGeometryEffect(id: "123", in: nameSpace)

                            .frame(width: 300, height: 300, alignment: .center)
                            .onTapGesture {
                                isExpanded.toggle()
                            }
                    }
                    
                }
            }
                
            
            .task {
                vm.manager.requestAccess { isSuccess in
                    guard !isSuccess else { return }
                    

                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    let manager = HealthKitManager()
    CatalogueView(manager: manager)
}
