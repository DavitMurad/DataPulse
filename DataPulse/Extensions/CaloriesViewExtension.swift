//
//  CaloriesViewExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 06.06.26.
//

import SwiftUI
import Charts

extension CaloriesView {
    var closeButton: some View {
        CloseButtonView(foreGroundColor: .green) {
            closeButtonPressed()
        }
    }
    var calsToday: some View {
        GroupBox {
            VStack {
                Text("Burned calories today.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                
                Text(caloriesVM.caloriesData?.latest ?? 0.0, format: .number)
                    .withSubTitleTextFormmatting(font: .headline, foregroundColor: .secondary)
                
            }
        }
    }
    var calsProgressView: some View {
        GroupBox {
            VStack {
                Text("Burned calories across this week.")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if let caloriesData = caloriesVM.caloriesData {
                            ForEach(caloriesData.weeklyCaloriesBurned) { cals in
                                CalorieProgressView(progress: (cals.value / caloriesVM.recommendedNEAT), date: cals.date)
                                    .frame(height: 300)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var calsText: some View {
        GroupBox {
            VStack {
                Text("Note")
                    .withSubTitleTextFormmatting(font: .title3, foregroundColor: .primary)
                Text(caloriesVM.calNote)
                .withSubTitleTextFormmatting(font: .footnote, foregroundColor: .secondary, fontWeight: .regular)
            }
        }
    }
}

