//
//  ContentView.swift
//  ClippyMobile
//
//  Created by Alan Maia on 10/01/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab(MainConstants.homeText, systemImage: MainConstants.homeIcon) {
                HomeView()
            }
            Tab(MainConstants.settingsText, systemImage: MainConstants.settingsIcon){
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
