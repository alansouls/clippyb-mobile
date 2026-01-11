//
//  SettingsRepository.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation

class SettingsRepository {
    static let Instance = SettingsRepository()
    
    var serviceBusConnection = ""
    var encryptionKey : Data? = nil
}
