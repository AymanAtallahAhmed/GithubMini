//
//  LogInUseCase.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol LogInUseCaseProtocol {
    func isLoggedIn() async -> Bool
    func startDeviceLogin() async throws -> AuthFlowEntity
    func pollForDeviceToken(flow: AuthFlowEntity) async throws
}

struct LogInUseCase: LogInUseCaseProtocol {
    let authRepository: AuthRepoProtocol

    func isLoggedIn() async -> Bool {
        await authRepository.isLoggedIn()
    }

    func startDeviceLogin() async throws -> AuthFlowEntity {
        try await authRepository.startDeviceLogin()
    }

    func pollForDeviceToken(flow: AuthFlowEntity) async throws {
        try await authRepository.pollForDeviceToken(flow: flow)
    }
}
