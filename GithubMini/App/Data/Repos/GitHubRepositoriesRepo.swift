//
//  GitHubRepositoriesRepo.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation
import Networking
import SecureStorage

final class GitHubRepositoriesRepo: GitHubRepositoriesRepoProtocol {
    private let networkManager: NetworkingManagerProtocol
    private let secureDataManger: SecureDataManagerProtocol

    init(
        network: NetworkingManagerProtocol,
        secureDataManger: SecureDataManagerProtocol
    ) {
        self.networkManager = network
        self.secureDataManger = secureDataManger
    }

    func fetchRepos(page: Int) async throws -> [GitRepoEntity] {
        guard let token = await secureDataManger.retrieve(for: "user token") else { throw URLError(.userAuthenticationRequired) }
        var request = URLRequest(url: URL(string: "https://api.github.com/user/repos?page=\(page)&per_page=10")!)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        let repos: [GitRepoDTO] = try await networkManager.request(request)
        return repos.map { $0.mapToEntity() }
    }

    func fetchBranches(repo: String, page: Int) async throws -> [BranchEntity] {
        guard let token = await secureDataManger.retrieve(for: "user token") else { throw URLError(.userAuthenticationRequired) }
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/\(repo)/branches?page=\(page)&per_page=10")!)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        let branches: [BranchDTO] = try await networkManager.request(request)
        return branches.map { $0.mapToEntity() }
    }
}
