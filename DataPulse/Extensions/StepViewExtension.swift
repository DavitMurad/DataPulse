//
//  StepViewExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 04.06.26.
//

import SwiftUI
import Charts

extension StepsView {
    
    var closeButtonView: some View {
        
        CloseButtonView(foreGroundColor: .blue) {
            closeButtonPressed()
        }
    }
    
    var stepsForTodayView: some View {
        GroupBox {
            VStack {
                Text("Your steps for today.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text(stepsVM.stepData?.latest ?? 0, format: .number)
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
            }
        }
    }
    
    var barChartView : some View {
        GroupBox {
            VStack {
                Text("Your weekly steps on average.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text(stepsVM.stepData?.weeklyAvg ?? 0, format: .number.precision(.fractionLength(0)))
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
                Chart {
                    if let stepData = stepsVM.stepData {
                        RuleMark(y: .value("Goal", 7500))
                            .foregroundStyle(.pink)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                            .annotation(alignment: .leading) {
                                Text("Daily Goal")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 7)
                            }
                        ForEach(stepData.weekly) { data in
                            BarMark(
                                x: .value("Day", data.date),
                                y: .value("Steps", data.value)
                            )
                            .foregroundStyle(.blue.gradient)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: .stride(by: .day))
                }
                .chartXScale(domain: stepsVM.XAxisScale)
                .padding(.horizontal, 15)
            }
        }
    }
    
    var pieChartView: some View {
        GroupBox {
            VStack {
                Text("Your monthly step distribution across weeks.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text("\(stepsVM.stepData?.monthlySum ?? 0.0, format: .number)")
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
                if let stepData = stepsVM.stepData {
                    Chart(stepData.weeklySum) { sum in
                        SectorMark(angle: .value(Text(verbatim: sum.date.formatted(.dateTime.week().weekday())), sum.value),
                                   innerRadius: .ratio(0.6))
                        .annotation(position: .overlay, content: {
                            Text("\(sum.value.kFormat)")
                                .font(.caption)
                                .foregroundStyle(.white)
                        })
                        .foregroundStyle(by: .value("Week", sum.date.formatted(.dateTime.month(.abbreviated).day())))
                    }
                }
            }
        }
    }
}
