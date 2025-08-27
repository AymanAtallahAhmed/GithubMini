//
//  FetchReposUseCase.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol FetchReposUseCaseProtocol {
    func execute(page: Int) async throws -> [GitRepoEntity]
}

struct FetchReposUseCase: FetchReposUseCaseProtocol {
    private let repository: GitHubRepositoriesRepoProtocol

    init(repository: GitHubRepositoriesRepoProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [GitRepoEntity] {
        try await repository.fetchRepos(page: page)
    }
}
