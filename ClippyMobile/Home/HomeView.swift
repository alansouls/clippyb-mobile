//
//  HomeView.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var dataToSend: String = ""
    @State private var sentData: String = ""
    
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
                sentData = dataToSend
            }, label: {
                Label(
                    HomeConstants.buttonSendFromFieldText,
                    systemImage: HomeConstants.buttonSendFromFieldIcon
                )
            })
            .roundedButton()
            
            Button(action: {
                sentData = dataToSend
            }, label: {
                Label(HomeConstants.buttonSendFromCredentialsText, systemImage: HomeConstants.buttonSendFromCredentialsIcon)
            })
            .roundedButton()
        }
        .defaultStyle()
    }
}

#Preview {
    HomeView()
}
