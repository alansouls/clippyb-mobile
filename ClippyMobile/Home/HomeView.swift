//
//  HomeView.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI
import AuthenticationServices

struct HomeView: View {
    private let messagingService = getMessagingService()
    @State private var showError = false
    @State private var dataToSend: String = ""
    @State private var showPasswordSelector = false
    
    static private func getMessagingService() -> MessagingService {
        AzureServiceBusService(
            serviceBusName: SettingsRepository.Instance.serviceBusName,
            serviceBusKeyName: SettingsRepository.Instance.serviceBusKeyName,
            serviceBusKey: SettingsRepository.Instance.serviceBusKey,
            queueName: "clippy-queue")
    }
    
    private func sendData(data: String) async throws {
        let encryptionService = EncryptionService()
        
        let encryptedData = try encryptionService.encryptData(data: Data(data.utf8))
            .byteArray.toBase64()
        
        try await messagingService.send(message: ClippyMessage(source: "Iphone", encryptedData: encryptedData))
    }
    
    private func sendDataHandled(data: String) async {
        do {
            try await sendData(data: data)
        }
        catch {
            showError = true
        }
    }
    
    private func requestCredentials() {
        showPasswordSelector = true
    }
    
    var body: some View {
        VStack {
            Text(HomeConstants.pageTitle)
                .font(.title)
            
            Spacer()
                .frame(height: 100)
            
            TextField(HomeConstants.textFieldSendText,
                  text: $dataToSend
            )
            .textFieldStyle(.roundedBorder)
            
            Button(action: {
                Task {
                    await sendDataHandled(data: dataToSend)
                }
            }, label: {
                Label(
                    HomeConstants.buttonSendFromFieldText,
                    systemImage: HomeConstants.buttonSendFromFieldIcon
                )
            })
            .roundedButton()
            .alert("Error sending data", isPresented: $showError) {
                Button("OK", role: .cancel) {
                    
                }
            }
            
            Button(action: {
                requestCredentials()
            }, label: {
                Label(HomeConstants.buttonSendFromCredentialsText, systemImage: HomeConstants.buttonSendFromCredentialsIcon)
            })
            .roundedButton()
        }
        .defaultStyle()
        .sheet(isPresented: $showPasswordSelector, content: {
            PasswordSelectorModal(isPresented: $showPasswordSelector) { password in
                Task {
                    try await sendDataHandled(data: password)
                }
            }
        })
    }
}

#Preview {
    HomeView()
}
