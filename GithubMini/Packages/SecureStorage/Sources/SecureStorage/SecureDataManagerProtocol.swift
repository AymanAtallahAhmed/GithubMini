//
//  SecureDataManagerProtocol.swift
//  SecureStorage
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

public protocol SecureDataManagerProtocol: Actor {
    func save(key: String, data: Data) -> OSStatus
    func retrieve(for key: String) -> Data?
    func deleteAll()
}
