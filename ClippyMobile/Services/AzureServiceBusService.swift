//
//  AzureServiceBusService.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import CryptoSwift
import Foundation

class AzureServiceBusService : MessagingService {
    let serviceBusName: String
    let serviceBusKeyName: String
    let serviceBusKey: String
    let queueName: String
    
    init(serviceBusName: String, serviceBusKeyName: String, serviceBusKey: String, queueName: String) {
        self.serviceBusName = serviceBusName
        self.serviceBusKeyName = serviceBusKeyName
        self.serviceBusKey = serviceBusKey
        self.queueName = queueName
    }
    
    func send(message: ClippyMessage) async throws {
        let serviceBusUrl = "https://\(serviceBusName).servicebus.windows.net/\(queueName)"
        // Construct the Service Bus URL
        let resourceUrl = serviceBusUrl  + "/messages"
        
        guard let url = URL(string: resourceUrl) else {
            throw ServiceBusError.invalidURL
        }
        
        // Generate SAS Token
        let sasToken = try generateSASToken(
            resourceUrl: serviceBusUrl,
            keyName: serviceBusKeyName,
            key: serviceBusKey,
            expiryInSeconds: 3600 // 1 hour
        )
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(sasToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set the message body
        let jsonEncoder = JSONEncoder()
        request.httpBody = try jsonEncoder.encode(message)
        
        // Make the request
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceBusError.invalidResponse
        }
        
        // Azure Service Bus returns 201 Created on success
        if httpResponse.statusCode != 201 {
            throw ServiceBusError.sendFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    private func generateSASToken(
        resourceUrl: String,
        keyName: String,
        key:  String,
        expiryInSeconds: Int
    ) throws -> String {
        
        // Calculate expiry time (Unix timestamp)
        let expiry = Int(Date().timeIntervalSince1970) + expiryInSeconds
        let expiryString = String(expiry)
        
        // URL encode the resource URL
        guard let encodedUrl = resourceUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw ServiceBusError.tokenGenerationFailed
        }
        
        // Create the string to sign
        let stringToSign = "\(encodedUrl)\n\(expiryString)"
        
        // Generate HMAC-SHA256 signature
        let signature = try hmacSHA256(string: stringToSign, key: key)
        
        // URL encode the signature
        guard let encodedSignature = signature.addingPercentEncoding(withAllowedCharacters: . urlQueryAllowed) else {
            throw ServiceBusError.tokenGenerationFailed
        }
        
        // Construct the SAS token
        let sasToken = "SharedAccessSignature sr=\(encodedUrl)&sig=\(encodedSignature)&se=\(expiryString)&skn=\(keyName)"
        
        return sasToken
    }
    
    private func hmacSHA256(string: String, key: String) throws -> String {
        try  HMAC(key: Array(key.utf8)).authenticate(Array(string.utf8)).toBase64()
    }
}

enum ServiceBusError:  LocalizedError {
    case invalidURL
    case invalidResponse
    case tokenGenerationFailed
    case sendFailed(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid Service Bus URL"
        case .invalidResponse:
            return "Invalid response from Service Bus"
        case . tokenGenerationFailed:
            return "Failed to generate SAS token"
        case .sendFailed(let statusCode):
            return "Failed to send message.  Status code: \(statusCode)"
        }
    }
}
