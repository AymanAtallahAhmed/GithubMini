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
    @StateObject private var appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LogInView(viewModel: .init(
                    loginUseCase: appContainer.loginUseCase,
                    logoutUseCase: appContainer.logoutUseCase))
            }
            .environmentObject(appContainer)
        }
    }
}
