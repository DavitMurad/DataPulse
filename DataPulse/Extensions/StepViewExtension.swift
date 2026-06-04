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
        Button {
            closeButtonPressed()
        } label: {
            Image(systemName: "x.circle")
                .withSubTitleTextFormmatting(font: .title, foregroundColor: .blue)
        }
    }
    
    var stepsForTodayView: some View {
        VStack {
            Text("Your steps for today:")
                .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
            Text(vm.stepData?.latest ?? 0, format: .number)
                .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
            
        }
    }
    
    var barChartView : some View {
        VStack {
            Text("Your weekly steps.")
                .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
            
            Chart {
                if let stepData = vm.stepData {
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
            .chartXScale(domain: Calendar.current.date(byAdding: .day, value: -7, to: .now)! ... .now)
            
            .padding(.horizontal, 15)
        }
    }
    
    var pieChartView: some View {
        VStack {
            Text("Your weekly step distribution across weeks.")
                .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
            
            if let stepData = vm.stepData {
                Chart(stepData.weekly) { day in
                    SectorMark(angle: .value(Text(verbatim: day.date.formatted(.dateTime.day().month())), day.value),
                               innerRadius: .ratio(0.6)
                    )
                    .annotation(position: .overlay, content: {
                        Text((String(format: "%.0f", day.value)))
                            .font(.caption)
                            .foregroundStyle(.white)
                    })
                    .foregroundStyle(
                        by: .value(
                            "Day",
                            day.date.formatted(.dateTime.month().day())
                        )
                    )
                }
                
                .chartBackground(content: { chartProxy in
                    
                })
            }
        }
    }
}
