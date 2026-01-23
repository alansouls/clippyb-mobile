//
//  ButtonExtensions.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation
import SwiftUI

extension Button {
    func primaryButton() -> some View {
        self
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.appPrimary)
            }
            .bold()
            .foregroundStyle(.primary)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .frame(minWidth: 50)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)

    }
}

extension Label {
    func defaultButtonLabel() -> some View {
        self
            .font(.body)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
    }
}

#Preview {
    Button(action: {
        
    },label: {
        Label("Send", systemImage: "")
            .defaultButtonLabel()
    })
    .primaryButton()
}
