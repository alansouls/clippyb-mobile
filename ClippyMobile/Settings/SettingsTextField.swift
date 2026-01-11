//
//  SettingsTextField.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI

struct SettingsTextField: View {
    let label: String
    let required: Bool
    var value : Binding<String>
    
    var body: some View {
        LabeledContent {
            TextField(text: value, label: {
                Text(required ? "Type the value here *" : "Type the value here")
            })
            .textFieldStyle(.roundedBorder)
        } label: {
            Text(label)
        }
    }
}

#Preview {
    @Previewable @State var test = ""
    SettingsTextField(label: "Test", required: true, value: $test)
}
