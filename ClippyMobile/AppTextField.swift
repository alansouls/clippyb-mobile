//
//  SettingsTextField.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI

struct AppTextField: View {
    let placeholder: String
    var value : Binding<String>
    let label: String?
    let contentType: UITextContentType?
    
    var body: some View {
        VStack {
            if (label != nil) {
                HStack {
                    Text(label!)
                        .defaultStyle(.label, color: .label)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            TextField(text: value, label: {
                Text(placeholder)
                    .defaultStyle(.button, color: .fieldPlaceholder)
            })
            .padding(10)
            .cornerRadius(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .fill(.appPrimary)
            }
            .textContentType(contentType)
        }
    }
}

#Preview {
    @Previewable @State var test = ""
    VStack {
        AppTextField(placeholder: "This the place holder", value: $test, label: "test", contentType: nil)
        
        AppTextField(placeholder: "What?", value: $test, label: "oadkw", contentType: nil)
    }
    .padding()
}
