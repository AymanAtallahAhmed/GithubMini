//
//  SecureDataManager.swift
//  SecureStorage
//
//  Created by Ayman on 27/08/2025.
//

import Security
import Foundation

public actor SecureDataManager: SecureDataManagerProtocol {

    public init() {}

    @discardableResult
    public func save(key: String, data: Data) -> OSStatus {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String : data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }

    /// Fetching data from KeyChain for that key
    public func retrieve(for key: String) -> Data? {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        return status == noErr ? dataTypeRef as! Data? : nil
    }

    public func deleteAll() {
        let secItemClasses =  [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity,
        ]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}
