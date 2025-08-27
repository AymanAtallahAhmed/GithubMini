//
//  GithubMiniApp.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import SwiftUI
import SecureStorage

@main
struct GithubMiniApp: App {
    let appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            LogInView(viewModel: .init(
                loginUseCase: appContainer.loginUseCase,
                logoutUseCase: appContainer.logoutUseCase))
        }
    }
}
