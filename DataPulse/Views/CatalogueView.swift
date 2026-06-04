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
            GeometryReader { geom in
                ScrollView(showsIndicators: false) {
                    ZStack {
                        VStack(spacing: 50) {
                            HStack(spacing: 50) {
                                HKCategoryView(color: .blue, systemImageName: "shoeprints.fill", title: "Steps", rotationDegree: 0, namespace: namespace, isExpanded: $isExpanded) {
                                    title = ViewTitlesOption.steps.title
                                    currentExpandedView = .steps
                                    withAnimation(.bouncy) {
                                        isExpanded.toggle()
                                    }
                                }

                                
                                HKCategoryView(color: .pink, systemImageName: "scalemass", title: "Weight", rotationDegree: 0, namespace: namespace, isExpanded: $isExpanded) {
                                    title = ViewTitlesOption.weight.title
                                    currentExpandedView = .weight
                                    withAnimation(.bouncy) {
                                        isExpanded.toggle()
                                    }
                                }
                                
                            }
                            HStack(spacing: 50)  {
                                HKCategoryView(color: .green, systemImageName: "flame.fill", title: "Calories", rotationDegree: 45, namespace: namespace, isExpanded: $isExpanded) {
                                    title = ViewTitlesOption.calories.title
                                    currentExpandedView = .calories
                                    withAnimation(.bouncy) {
                                        isExpanded.toggle()
                                    }
                                }
                                
                                HKCategoryView(color: .orange, systemImageName: "figure.stairs", title: "Climbed", rotationDegree: 0,namespace: namespace, isExpanded: $isExpanded) {
                                    title = ViewTitlesOption.climbed.title
                                    currentExpandedView = .climbed
                                    withAnimation(.bouncy) {
                                        isExpanded.toggle()
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
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .gray.opacity(0.5), radius: 5)
                                    .frame(height: geom.size.height)
                                    .padding()
                                    .onTapGesture {
                                        
                                    }
                            case .weight:
                                WeightView(manager: manager)
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .gray.opacity(0.5), radius: 5)
                                    .frame(height: geom.size.height)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                            case .calories:
                                CaloriesView(manager: manager)
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .gray.opacity(0.5), radius: 5)
                                    .frame(height: geom.size.height)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                            case .climbed:
                                ClimbView(manager: manager)
                                    .matchedGeometryEffect(id: title, in: namespace)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .gray.opacity(0.5), radius: 5)
                                    .frame(height: geom.size.height)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                            }
                       
                            
                        }
                        
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 5)
                .navigationTitle("Activity")
                .navigationBarTitleDisplayMode(.automatic)
            }
            .task {
                vm.manager.requestAccess { isSuccess in
                    guard !isSuccess else { return }
                    
                    
                }
            }
        
        }
    }
}

#Preview {
    let manager = HealthKitManager()
    CatalogueView(manager: manager)
}
