//
//  CalorieProgressView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 05.06.26.
//

import SwiftUI

struct CalorieProgressView: View {
    let progress: Double
    let date: Date
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(height: 50)
                .shadow(radius: 3)
                .padding()
                .overlay {
                    Text("\(date.formatted(.dateTime.day().month()))")
                        
                }
                .padding()

            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.secondary)
                
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 0.5)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: 270.0))
                
                Circle()
                    .trim(from: CGFloat(abs((min(progress, 1.0))-0.001)), to: CGFloat(abs((min(progress, 1.0))-0.0005)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 10, x: 0, y: 0)
                    .rotationEffect(Angle(degrees: 270.0))
                    .clipShape(
                        Circle().stroke(lineWidth: 20)
                    )
                
                Circle()
                    .trim(from: progress > 0.5 ? 0.25 : 0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(UIColor.systemGreen))
                    .rotationEffect(Angle(degrees: 270.0))
            }
            .padding()
            .padding(.horizontal, 10)
            .overlay {
                VStack {
                    Text("\(Int(progress * 300)) / 300")
                        .font(.title3)
                    //                    .foregroundStyle(.green)
                        .fontWeight(.semibold)
                    Text("\(Int(progress * 100))%")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fontWeight(.semibold)
                    
                }
            }
        }
    }
}

#Preview {
    CalorieProgressView(progress: 1.25, date: .now)
}
