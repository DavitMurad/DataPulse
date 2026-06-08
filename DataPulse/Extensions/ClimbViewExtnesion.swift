//
//  ClimbViewExtnesion.swift
//  DataPulse
//
//  Created by Davit Muradyan on 06.06.26.
//

import SwiftUI
import Charts


extension ClimbView {
    var backButtonView: some View {
        CloseButtonView(foreGroundColor: .orange) {
            closeButtonPressed()
        }
    }
    var climbedTodayView: some View {
        GroupBox {
            VStack {
                Text("Your climbed stairs for today.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text(climbedVM.climbedData?.latest ?? 0, format: .number)
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
            }
        }
    }
    
    var weeklyClimbedBarView: some View {
        GroupBox {
            VStack {
                Text("Your weekly climbed stairs on average.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                
                Text(climbedVM.climbedData?.weeklyAvg ?? 0, format: .number.precision(.fractionLength(0)))
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
                Chart {
                    if let climbedData = climbedVM.climbedData {
                        RuleMark(x: .value("Goal", 4))
                            .foregroundStyle(.blue)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                            .annotation(alignment: .top) {
                                Text("Daily Goal")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        ForEach(climbedData.weekly) { data in
                            BarMark(
                                x: .value("Climbed", data.value) ,
                                y: .value("Day", data.date)
                            )
                            .foregroundStyle(.orange.gradient)
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .trailing, values: .stride(by: .day))
                }
                
                .padding(.horizontal, 15)
            }
        }
    }
    
    var monthlyDistributionAcrossWeekView: some View {
        GroupBox {
            VStack {
                Text("Your monthly climbed distribution across weeks.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text("\(climbedVM.climbedData?.monthlySum ?? 0.0, format: .number)")
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
                if let climbedData = climbedVM.climbedData {
                    Chart(climbedData.weeklySum) { sum in
                        SectorMark(angle: .value(Text(verbatim: sum.date.formatted(.dateTime.week().weekday())), sum.value))
                            .annotation(position: .overlay, content: {
                                Text("\(sum.value, format: .number)")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            })
                            .foregroundStyle(by: .value("Week", sum.date.formatted(.dateTime.month().day())))
                    }
                }
            }
        }
    }
}

