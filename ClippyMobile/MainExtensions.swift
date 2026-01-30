//
//  MainExtensions.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation
import SwiftUI

extension VStack {
    func defaultStyle() -> some View{
        self
            .padding()
            .lineSpacing(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(.appBackground)
    }
}

struct FontTypo {
    static let title = FontTypo(size: 24, weight: .bold)
    static let tab = FontTypo(size: 20, weight: .semibold)
    static let button = FontTypo(size: 16, weight: .medium)
    static let label = FontTypo(size: 14, weight: .regular)
    
    let size: CGFloat
    let weight: Font.Weight
}

extension Text {
    func defaultStyle(_ typo: FontTypo, color: Color? = nil) -> Text{
        self
            .foregroundColor(color ?? .appPrimary)
            .font(.custom("Roboto", size: typo.size))
            .fontWeight(typo.weight)
    }
}
