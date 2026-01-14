//
//  PasswordSelectorModal.swift
//  ClippyMobile
//
//  Created by Alan Maia on 14/01/2026.
//

import SwiftUI

struct PasswordSelectorModal: View {
    @State private var dataToSend = ""
    @Binding var isPresented: Bool
    let onConfirmed: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack{
                SecureField(HomeConstants.textFieldSendText,
                      text: $dataToSend
                )
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)
            }
            .defaultStyle()
            .navigationTitle("Type in a password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onConfirmed(dataToSend)
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isPresented = false
    PasswordSelectorModal(isPresented: $isPresented) { _ in
        
    }
}
