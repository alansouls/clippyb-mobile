//
//  ButtonExtensions.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation
import SwiftUI

extension Button {
    func roundedButton() -> some View {
        self
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBackground, lineWidth: 5)
            }
            .bold()
            .foregroundColor(.buttonText)
            .buttonStyle(.bordered)
            .clipShape(Capsule())
    }
}
