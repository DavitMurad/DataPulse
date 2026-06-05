//
//  BMIBarView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 05.06.26.
//

import SwiftUI

struct BMIBarView: View {
    let bmiScore: Double
    
    let slimMax = 18.5
    let normalMax = 25.0
    let overweightMax = 30.0
    let obeseMax = 40.0
    
    var perc: Double {
        bmiScore / obeseMax
    }
    
    var body: some View {
        GeometryReader { geom in
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: geom.size.width * slimMax / obeseMax)
                        Rectangle()
                            .fill(.green)
                            .frame(width: geom.size.width * (normalMax - slimMax) / obeseMax)
                        Rectangle()
                            .fill(.orange)
                            .frame(width: geom.size.width * (overweightMax - normalMax) / obeseMax)
                        Rectangle()
                            .fill(.red)
                    }
                    .frame(height: 20)
                    
                    Circle()
                        .fill(.white)
                        .stroke(.black, lineWidth: 1)
                        .frame(width: 20, height: 20)
                        .offset(x: geom.size.width * perc - 10)
                }
                
                HStack(spacing: 0) {
                    Text("0")
                        .frame(width: geom.size.width * slimMax / obeseMax, alignment: .leading)
                    Text("18.5")
                        .frame(width: geom.size.width * (normalMax - slimMax) / obeseMax, alignment: .leading)
                    Text("25")
                        .frame(width: geom.size.width * (overweightMax - normalMax) / obeseMax, alignment: .leading)
                    Text("30")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("40")
                        .frame(alignment: .trailing)
                }
                .font(.caption)
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    BMIBarView(bmiScore: 24.5)
}
