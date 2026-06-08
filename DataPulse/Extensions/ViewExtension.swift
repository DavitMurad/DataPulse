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

struct CategoryCardViewModifier: ViewModifier {
    let geom: GeometryProxy
    func body(content: Content) -> some View {
        return content
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .gray.opacity(0.5), radius: 5)
            .frame(height: geom.size.height)
            .padding()
    }
}



extension View {
    func withSubTitleTextFormmatting(font: Font, foregroundColor: Color, fontWeight: Font.Weight = .semibold) -> some View {
        self.modifier(SubTitleTextModifier(font: font, foregroundColor: foregroundColor, fontWeight: fontWeight))
    }
    
    func withCategoryCardModifier(_ geom: GeometryProxy) -> some View {
        self.modifier(CategoryCardViewModifier(geom: geom))
    }
}
