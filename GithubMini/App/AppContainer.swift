//
//  AppContainer.swift
//  GithubMini
//
//  Created by Ayman on 28/08/2025.
//

import Foundation
import Networking
import SecureStorage

final class AppContainer: ObservableObject {
    // Data layer
    let networkingManager: NetworkingManagerProtocol
    let secureDataManger: SecureDataManagerProtocol
    let authRepository: AuthRepoProtocol
    let gitHubRepositoriesRepo: GitHubRepositoriesRepoProtocol

    // Domain layer (UseCases)
    let loginUseCase: LogInUseCaseProtocol
    let logoutUseCase: LogoutUseCaseProtocol
    let fetchReposUseCase: FetchReposUseCaseProtocol
    let fetchBranchesUseCase: FetchBranchesUseCaseProtocol
    
    init() {
        self.networkingManager = NetworkingManager()
        self.secureDataManger = SecureDataManager()

        self.authRepository = GithubAuthRepo(
            clientId: "",
            networkManager: networkingManager,
            secureDataManger: secureDataManger
        )
        self.gitHubRepositoriesRepo = GitHubRepositoriesRepo(
            network: networkingManager,
            secureDataManger: secureDataManger)
        
        // Use cases
        self.loginUseCase = LogInUseCase(authRepository: authRepository)
        self.logoutUseCase = LogoutUseCase(authRepository: authRepository)
        self.fetchReposUseCase = FetchReposUseCase(repository: gitHubRepositoriesRepo)
        self.fetchBranchesUseCase = FetchBranchesUseCase(repository: gitHubRepositoriesRepo)
    }
}
