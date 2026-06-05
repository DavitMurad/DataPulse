//
//  CloseButtonView.swift
//  DataPulse
//
//  Created by Davit Muradyan on 04.06.26.
//

import SwiftUI

struct CloseButtonView: View {
    let foreGroundColor: Color
    let closeButtonPressed: () -> ()
    var body: some View {
        Button {
            closeButtonPressed()
        } label: {
            Image(systemName: "xmark")
                .withSubTitleTextFormmatting(font: .title2, foregroundColor: foreGroundColor)
        }
    }
}

//#Preview {
//    CloseButtonView()
//}
