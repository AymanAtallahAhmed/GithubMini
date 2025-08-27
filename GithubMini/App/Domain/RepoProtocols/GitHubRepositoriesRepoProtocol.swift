//
//  GitHubRepositoriesRepoProtocol.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol GitHubRepositoriesRepoProtocol {
    func fetchRepos(page: Int) async throws -> [GitRepoEntity]
    func fetchBranches(repo: String, page: Int) async throws -> [BranchEntity]
}
