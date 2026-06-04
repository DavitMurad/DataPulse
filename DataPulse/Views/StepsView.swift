//
//  StepsView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 31.05.26.
//

import SwiftUI
import Charts

struct StepsView: View {
    @StateObject var vm: StepsViewModel
    
    var closeButtonPressed: () -> ()
    
    init(manager: HKDataManagerProtocol, closeButtonPressed: @escaping () -> () ) {
        _vm = StateObject(wrappedValue: StepsViewModel(manager: manager))
        self.closeButtonPressed = closeButtonPressed
        
    }
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Group {
                    Button {
                        closeButtonPressed()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                            .padding(.bottom)
                        
                    }
                    Text("Your steps for today:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(vm.stepData?.latest ?? 0, format: .number)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                
                Divider()
                
                Spacer()
                
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
                
                .frame(height: 200)
                .padding(.horizontal, 30)
                
                Divider()
                Spacer()
                
                if let stepData = vm.stepData {
                    Chart(stepData.weekly) { day in
                        SectorMark(
                            angle: .value(Text(verbatim: day.date.formatted(.dateTime.day().month())),day.value),
                            innerRadius: .ratio(0.6)
                        )
                        .foregroundStyle(
                            by: .value(
                                Text(verbatim: day.date.formatted(.dateTime.day().month())).font(.title),
                                day.value
                            )
                        )
                    }
                    .frame(height: 300)
                    
                }
                
            }
            .padding()
            
            .task {
                do {
                    try await vm.getStepsData()
                } catch {}
            }
        }
    }
}

#Preview {
    let manager = MockedHealthKitManager()
    StepsView(manager: manager) {
        print("asd")
    }
}
