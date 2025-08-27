//
//  AuthRepoProtocol.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol AuthRepoProtocol {
    func isLoggedIn() async -> Bool
    func startDeviceLogin() async throws -> AuthDeviceFlow
    func pollForDeviceToken(flow: AuthDeviceFlow) async throws
    func logout() async
}
