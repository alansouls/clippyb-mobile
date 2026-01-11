//
//  SettingsView.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI

struct SettingsView: View {
    @State var changed = false
    @State var serviceBusConnectionString = ""
    
    func saveSettings() {
        SettingsRepository.Instance.serviceBusConnection = serviceBusConnectionString
        changed = false
    }
    
    func cancelSettings() {
        serviceBusConnectionString = SettingsRepository.Instance.serviceBusConnection
        changed = false
    }
    
    var body: some View {
        VStack {
            SettingsTextField(
                label: SettingsConstants.textFieldServiceBus,
                required: true,
                value: $serviceBusConnectionString)
            .onChange(of: serviceBusConnectionString, {
                changed = serviceBusConnectionString != SettingsRepository.Instance.serviceBusConnection
            })
            
            if (changed) {
                Spacer()
                
                HStack {
                    Button(action: saveSettings, label: {
                        Label(SettingsConstants.buttonSaveSettingsTitle, systemImage: "checkmark")
                    })
                    .roundedButton()
                    
                    Button(action: cancelSettings, label: {
                        Label(SettingsConstants.buttonCancelSettingsChangeTitle, systemImage: "xmark")
                    })
                    .roundedButton()
                }
            }
        }
        .defaultStyle()
    }
}

#Preview {
    SettingsView()
}
