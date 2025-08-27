//
//  FetchBranchesUseCase.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol FetchBranchesUseCaseProtocol {
    func execute(repoId: String, page: Int) async throws -> [BranchEntity]
}

struct FetchBranchesUseCase: FetchBranchesUseCaseProtocol {
    private let repository: GitHubRepositoriesRepoProtocol

    init(repository: GitHubRepositoriesRepoProtocol) {
        self.repository = repository
    }

    func execute(repoId: String, page: Int) async throws -> [BranchEntity] {
        try await repository.fetchBranches(repo: repoId, page: page)
    }
}
