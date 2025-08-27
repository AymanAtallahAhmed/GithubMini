//
//  BranchesListViewModel.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

@MainActor
final class BranchesListViewModel: ObservableObject {
    @Published private(set) var branches: [BranchEntity] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    var title: String {
        repo.name
    }

    private let fetchBranches: FetchBranchesUseCaseProtocol
    private let repo: GitRepoEntity
    private var page = 1
    private let perPage = 10

    init(
        repo: GitRepoEntity,
        fetchBranches: FetchBranchesUseCaseProtocol
    ) {
        self.repo = repo
        self.fetchBranches = fetchBranches
    }

    func reset() {
        branches = []
        page = 1
    }

    func loadNextPageIfNeeded(force: Bool = false) async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let new = try await fetchBranches.execute(repoId: "\(repo.id)", page: page)
            if force || !new.isEmpty { branches.append(contentsOf: new); page += 1 }
        } catch {
            // Show error message here
        }
    }
}
