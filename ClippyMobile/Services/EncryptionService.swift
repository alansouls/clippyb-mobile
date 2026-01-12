//
//  EncryptionService.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import CryptoSwift
import Foundation

class EncryptionService {
    
    private func loadEncryptionKey(fileUrl: URL) throws -> Data  {
        let success = fileUrl.startAccessingSecurityScopedResource()
        let fileData = try NSData(contentsOf: fileUrl) as Data
        fileUrl.stopAccessingSecurityScopedResource()
        
        return fileData
    }
    
    func encryptData(data: Data) throws -> Data {
        let iv = AES.randomIV(AES.blockSize)
        let keyData = try loadEncryptionKey(fileUrl: SettingsRepository.Instance.encryptionKeyFileUrl!)
        
        let aes = try AES(key: keyData.byteArray, blockMode: CBC(iv: iv), padding: .pkcs7)
        
        let encryptedBytes = try data.encrypt(cipher: aes)
        
        return Data(iv + encryptedBytes)
    }
}
