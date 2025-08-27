//
//  GithubAuthRepo.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation
import Networking
import SecureStorage

final class GithubAuthRepo: AuthRepoProtocol {

    private let clientId: String
    private let networkManager: NetworkingManagerProtocol
    private let secureDataManger: SecureDataManagerProtocol

    init(
        clientId: String,
        networkManager: NetworkingManagerProtocol,
        secureDataManger: SecureDataManagerProtocol
    ) {
        self.clientId = clientId
        self.networkManager = networkManager
        self.secureDataManger = secureDataManger
    }

    func isLoggedIn() async -> Bool {
        await secureDataManger.retrieve(for: "user token") != nil
    }

    func startDeviceLogin() async throws -> AuthDeviceFlow {
        var req = URLRequest(url: URL(string: "https://github.com/login/device/code")!)
        req.httpMethod = "POST"
        let body = "client_id=\(clientId)&scope=repo%20read:user"
        req.httpBody = body.data(using: .utf8)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        let r: DeviceCodeResponse = try await networkManager.request(req)
        return AuthDeviceFlow(deviceCode: r.device_code, userCode: r.user_code, verificationURI: r.verification_uri, interval: r.interval)
    }

    func pollForDeviceToken(flow: AuthDeviceFlow) async throws {
        // Poll https://github.com/login/oauth/access_token
        let url = URL(string: "https://github.com/login/oauth/access_token")!
        let start = Date()
        while Date().timeIntervalSince(start) < 600 {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            let body = "client_id=\(clientId)&device_code=\(flow.deviceCode)&grant_type=urn:ietf:params:oauth:grant-type:device_code"
            req.httpBody = body.data(using: .utf8)
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            req.setValue("application/json", forHTTPHeaderField: "Accept")

            let tokenResp: TokenResponse = try await networkManager.request(req)
            if let token = tokenResp.access_token,
               let data = token.data(using: .utf8)
            {
                _ = await secureDataManger.save(key: "user key", data: data)
                return
            }

            // If not granted yet, wait `interval` seconds (server returns error "authorization_pending")
            try await Task.sleep(nanoseconds: UInt64(flow.interval) * 1_000_000_000)
        }
        throw URLError(.timedOut)
    }

    func logout() async {
        await secureDataManger.deleteAll()
    }
}
