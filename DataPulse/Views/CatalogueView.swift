//
//  CatalogueView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import HealthKit

enum ViewTitlesOption {
    case steps
    case weight
    case calories
    case climbed
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        case .calories:
            return "Calories"
        case .climbed:
            return "Climbed"
        }
    }
}


struct CatalogueView: View {
    @StateObject var vm: CatalogueViewModel
    @Namespace var namespace
    @State var title: String = ""
    @State private var isExpanded = false
    @State private var currentExpandedView: ViewTitlesOption = .steps
    
    let manager: HKDataManagerProtocol
    init(manager: HKDataManagerProtocol) {
        _vm = StateObject(wrappedValue: CatalogueViewModel(manager: manager))
        self.manager = manager
    }
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.88, green: 0.94, blue: 1.0),
                        Color(red: 0.96, green: 0.97, blue: 1.0),
                        Color(red: 1.0, green: 0.91, blue: 0.95)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                GeometryReader { geom in
                    ScrollView(showsIndicators: false) {
                        ZStack {
                            
                            VStack(spacing: 50) {
                                HStack(spacing: 50) {
                                    if !isExpanded {
                                        HKCategoryView(color: .blue, systemImageName: "shoeprints.fill", title: "Steps", rotationDegree: 0, namespace: namespace, isExpanded: $isExpanded) {
                                            title = ViewTitlesOption.steps.title
                                            currentExpandedView = .steps
                                            withAnimation(.easeInOut) {
                                                isExpanded.toggle()
                                            }
                                        }
                                    }
                                    
                                    if !isExpanded {
                                        HKCategoryView(color: .pink, systemImageName: "scalemass", title: "Weight", rotationDegree: 0, namespace: namespace, isExpanded: $isExpanded) {
                                            title = ViewTitlesOption.weight.title
                                            currentExpandedView = .weight
                                            withAnimation(.easeInOut) {
                                                isExpanded.toggle()
                                            }
                                        }
                                    }
                                    
                                }
                                HStack(spacing: 50)  {
                                    if !isExpanded {
                                        HKCategoryView(color: .green, systemImageName: "flame.fill", title: "Calories", rotationDegree: 0, namespace: namespace, isExpanded: $isExpanded) {
                                            title = ViewTitlesOption.calories.title
                                            currentExpandedView = .calories
                                            withAnimation(.easeInOut) {
                                                isExpanded.toggle()
                                            }
                                        }
                                    }
                                    if !isExpanded {
                                        HKCategoryView(color: .orange, systemImageName: "figure.stairs", title: "Climbed", rotationDegree: 0,namespace: namespace, isExpanded: $isExpanded) {
                                            title = ViewTitlesOption.climbed.title
                                            currentExpandedView = .climbed
                                            withAnimation(.easeInOut) {
                                                isExpanded.toggle()
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            if isExpanded {
                                switch currentExpandedView {
                                case .steps:
                                    
                                    StepsView(manager: manager) {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .withCategoryCardModifier(geom)
                                    
                                case .weight:
                                    WeightView(manager: manager) {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .withCategoryCardModifier(geom)
                                case .calories:
                                    CaloriesView(manager: manager) {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .withCategoryCardModifier(geom)
                                    
                                case .climbed:
                                    ClimbView(manager: manager) {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .withCategoryCardModifier(geom)
                                }
                                
                            }
                            
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 5)
                    .navigationTitle("Activity")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .task {
                    vm.manager.requestAccess { isSuccess in
                        guard !isSuccess else { return }
                        
                    }
                }
            }
        }
    }
}




#Preview {
    let manager = MockedHealthKitManager()
    CatalogueView(manager: manager)
}
