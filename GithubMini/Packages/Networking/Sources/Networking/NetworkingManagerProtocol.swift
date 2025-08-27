//
//  NetworkingManagerProtocol.swift
//  Networking
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

public protocol NetworkingManagerProtocol {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T
}
