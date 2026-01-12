//
//  SettingsView.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI
import UniformTypeIdentifiers

struct SettingsView: View {
    @State var selectingKey = false
    @State var changed = false
    @State var serviceBusName = ""
    @State var serviceBusKeyName = ""
    @State var serviceBusKey = ""
    @State var encryptionKeyFileName = ""
    @State var encryptionKeyFileUrl : URL?
    
    init() {
        cancelSettings()
    }
    
    func saveSettings() {
        SettingsRepository.Instance.serviceBusName = serviceBusName
        SettingsRepository.Instance.serviceBusKeyName = serviceBusKeyName
        SettingsRepository.Instance.serviceBusKey = serviceBusKey
        SettingsRepository.Instance.encryptionKeyFileUrl =
            encryptionKeyFileUrl
        changed = false
        SettingsRepository.Instance.persist()
    }
    
    func cancelSettings() {
        serviceBusName = SettingsRepository.Instance.serviceBusName
        serviceBusKeyName = SettingsRepository.Instance.serviceBusKeyName
        serviceBusKey = SettingsRepository.Instance.serviceBusKey
        encryptionKeyFileUrl = SettingsRepository.Instance.encryptionKeyFileUrl
        changed = false
    }
    
    func onKeyFileSelected(result: Result<URL, any Error>) {
        switch result {
        case .success(let fileUrl):
            encryptionKeyFileUrl = fileUrl
        case .failure(let error): break
        }
    }
    
    func onEncryptionKeyFileUrlChanged() {
        changed = encryptionKeyFileUrl != SettingsRepository.Instance.encryptionKeyFileUrl
        encryptionKeyFileName = encryptionKeyFileUrl?.lastPathComponent ?? ""
    }
    
    var body: some View {
        VStack {
            SettingsTextField(
                label: SettingsConstants.textFieldServiceBus,
                required: true,
                value: $serviceBusName)
            .onChange(of: serviceBusName, {
                changed = serviceBusName != SettingsRepository.Instance.serviceBusName
            })
            
            SettingsTextField(
                label: SettingsConstants.textFieldServiceBusKeyName,
                required: true,
                value: $serviceBusKeyName)
            .onChange(of: serviceBusKeyName, {
                changed = serviceBusKeyName != SettingsRepository.Instance.serviceBusKeyName
            })
            
            SettingsTextField(
                label: SettingsConstants.textFieldServiceBusKey,
                required: true,
                value: $serviceBusKey)
            .onChange(of: serviceBusKey, {
                changed = serviceBusKey != SettingsRepository.Instance.serviceBusKey
            })
            
            LabeledContent {
                Button(action: {
                    selectingKey = true
                }, label: {
                    let label = encryptionKeyFileName.isEmpty ?
                    SettingsConstants.buttonSelectEncryptionKey :
                    encryptionKeyFileName
                    Label(label, systemImage: "folder")
                })
                .roundedButton()
                .fileImporter(isPresented: $selectingKey, allowedContentTypes: [UTType(filenameExtension: "bin")!], onCompletion: onKeyFileSelected)
                .onChange(of: encryptionKeyFileUrl, onEncryptionKeyFileUrlChanged)
            } label: {
                Text("Encryption Key")
            }
            
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
