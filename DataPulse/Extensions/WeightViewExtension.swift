//
//  WeightViewExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 05.06.26.
//

import SwiftUI
import Charts

extension WeightView {
    var closeButton: some View {
        VStack(spacing: 20) {
            CloseButtonView(foreGroundColor: .pink) {
                closeButtonPressed()
            }
        }
    }
    
    var weightGraphView: some View {
        GroupBox {
            VStack {
                Text("Your weight this week on average.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                
//                Text((String(format: "%.1f",weightVM.weightdData?.weeklyAvgWeight ?? 0)))
                Text(weightVM.weightdData?.weeklyAvgWeight ?? 0, format: .number.precision(.fractionLength(1)))
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
                Chart {
                    if let weightData = weightVM.weightdData {
                        ForEach(weightData.weight) { data in
                            LineMark(
                                x: .value("Date", data.date),
                                y: .value("Weight", data.value)
                            )
                            .foregroundStyle(.pink.gradient)
                            
                            PointMark(
                                x: .value("Date", data.date),
                                y: .value("Weight", data.value)
                            )
                            .foregroundStyle(.pink.gradient)
                        }
                        
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: .stride(by: .day))
                }
                .chartXScale(domain: weightVM.getDateDomain)
                .chartYScale(domain: weightVM.getLastWeight)
                .padding(.horizontal, 15)
            }
        }
    }
    
    var bfGraphView: some View {
        GroupBox {
            VStack {
                Text("Your body fat this week.")
                    .withSubTitleTextFormmatting(font: .title2, foregroundColor: .primary)
                Text(weightVM.weightdData?.weeklyAvgBF ?? 0, format: .number.precision(.fractionLength(1)))
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                Chart {
                    
                    if let weightData = weightVM.weightdData {
                        ForEach(weightData.bodyFat) { data in
                            LineMark(
                                x: .value("Date", data.date),
                                y: .value("Body Fat", data.value)
                            )
                            .foregroundStyle(.red.gradient)
                            
                            PointMark(
                                x: .value("Date", data.date),
                                y: .value("Body Fat", data.value)
                            )
                            .foregroundStyle(.red.gradient)
                        }
                    }
                    
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: .stride(by: .day))
                }
                .chartXScale(domain: weightVM.getDateDomain)
                .chartYScale(domain: weightVM.getLastBodyFat)
                .padding(.horizontal, 15)
            }
        }
    }
    
    var bmiBarView: some View {
        GroupBox {
            VStack {
                Text("Your BMI today.")
                    .withSubTitleTextFormmatting(font: .title2, foregroundColor: .primary)
                Text(weightVM.weightdData?.bmi.value ?? 0, format: .number.precision(.fractionLength(1)))
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                BMIBarView(bmiScore: weightVM.weightdData?.bmi.value ?? 0)
            }
        }
    }
}
