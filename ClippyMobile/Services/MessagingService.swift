//
//  MessagingService.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation

struct ClippyMessage : Codable {
    let source: String
    let encryptedData: String
}

protocol MessagingService {
    func send(message: ClippyMessage) async throws
}
