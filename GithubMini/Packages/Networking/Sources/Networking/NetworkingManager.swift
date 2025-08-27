//
//  NetworkingManager.swift
//  Networking
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

public final class NetworkingManager: NetworkingManagerProtocol {
    public init() {}

    public func request<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        print("network request is: \(request)")
        let (data, response) = try await URLSession.shared.data(for: request)
        print("Network Response is: \(response)")
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
