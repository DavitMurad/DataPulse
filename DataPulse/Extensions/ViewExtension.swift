//
//  ViewExtension.swift
//  DataPulse
//
//  Created by Davit Muradyan on 04.06.26.
//

import SwiftUI

struct SubTitleTextModifier: ViewModifier {
    let font: Font
    let foregroundColor: Color
    let fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func withSubTitleTextFormmatting(font: Font, foregroundColor: Color, fontWeight: Font.Weight = .semibold) -> some View {
        self.modifier(SubTitleTextModifier(font: font, foregroundColor: foregroundColor, fontWeight: fontWeight))
    }
}
