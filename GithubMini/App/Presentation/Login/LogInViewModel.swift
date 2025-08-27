//
//  LogInViewModel.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

@MainActor
final class LogInViewModel: ObservableObject {
    enum State {
        case idle, loading, waitingForUser(code: String, url: String), loggedIn, error(String)
    }

    @Published private(set) var state: State = .idle

    private let loginUseCase: LogInUseCaseProtocol
    private let logoutUseCase: LogoutUseCaseProtocol

    init(
        loginUseCase: LogInUseCaseProtocol,
        logoutUseCase: LogoutUseCaseProtocol
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        Task { await bootstrap() }
    }

    func bootstrap() async {
        state = (await loginUseCase.isLoggedIn()) ? .loggedIn : .idle
    }

    func startLogin() {
        Task {
            do {
                state = .loading
                let flow = try await loginUseCase.startDeviceLogin()
                state = .waitingForUser(code: flow.userCode, url: flow.verificationURI)
                // Start polling but keep UI responsive
                Task.detached(priority: .userInitiated) {
                    do {
                        try await self.loginUseCase.pollForDeviceToken(flow: flow)
                        await MainActor.run { self.state = .loggedIn }
                    } catch {
                        await MainActor.run { self.state = .error("Failed to obtain token: \(error.localizedDescription)") }
                    }
                }
            } catch {
                state = .error("Failed to start login: \(error.localizedDescription)")
            }
        }
    }

    func logout() {
        Task {
            await logoutUseCase.execute()
            state = .idle
        }
    }
}
