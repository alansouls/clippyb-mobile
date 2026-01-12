//
//  SettingsRepository.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation

class SettingsRepository {
    static let Instance = SettingsRepository()
    
    var serviceBusName = ""
    var serviceBusKeyName = ""
    var serviceBusKey = ""
    var encryptionKeyFileUrl: URL?
    
    func persist() {
        UserDefaults.standard.set(serviceBusName, forKey: "serviceBusName");
        UserDefaults.standard.set(serviceBusKeyName, forKey: "serviceBusKeyName");
        UserDefaults.standard.set(serviceBusKey, forKey: "serviceBusKey");
        UserDefaults.standard.set(encryptionKeyFileUrl, forKey: "encryptionKeyFileUrl");
    }
    
    func restore() {
        serviceBusName = UserDefaults.standard.string(forKey: "serviceBusName") ?? ""
        serviceBusKeyName = UserDefaults.standard.string(forKey: "serviceBusKeyName") ?? ""
        serviceBusKey = UserDefaults.standard.string(forKey: "serviceBusKey") ?? ""
        encryptionKeyFileUrl = UserDefaults.standard.url(forKey: "encryptionKeyFileUrl")
    }
}
