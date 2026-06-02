//
//  HKCategoryView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 02.06.26.
//

import SwiftUI

struct HKCategoryView: View {
    let color: Color
    let systemImageName: String
    let title: String
    let rotationDegree: Double 
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(colors: [color.opacity(0.4), color], startPoint: .top, endPoint: .bottom))
//                    .frame(width: 150, height: 150)
                
                Grid(horizontalSpacing: 20, verticalSpacing: 18) {
                    GridRow {
                        ForEach(0..<4) { _ in
                            Image(systemName: systemImageName).rotationEffect(.degrees(rotationDegree))
                            
                        }
                    }
                    
                    GridRow {
                        ForEach(0..<4) { _ in
                            Image(systemName: systemImageName).rotationEffect(.degrees(rotationDegree))
                            
                        }
                    }
                    .offset(y: -12)
                    
                    GridRow {
                        ForEach(0..<4) { _ in
                            Image(systemName: systemImageName).rotationEffect(.degrees(rotationDegree))
                            
                        }
                        
                    }
                    .offset(y: 12)
                    GridRow {
                        ForEach(0..<4) { _ in
                            Image(systemName: systemImageName).rotationEffect(.degrees(rotationDegree))
                            
                        }
                    }
                }
                .foregroundStyle(.black.opacity(0.5))
                .blendMode(.overlay)
                .font(.headline)
                
                Text(title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.system(size: 35, weight: .black))
                
                    .foregroundStyle(.black.opacity(0.9))
                    .blendMode(.overlay)
                    .frame(width: 140)
                    .padding(.horizontal)
            }
    }
}

//#Preview {
//    HKCategoryView(color: .orange, systemImageName: "flame.fill", title: "Calories", rotationDegree: 45)
//}
