//
//  ReposListViewModel.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

@MainActor
final class ReposListViewModel: ObservableObject {
    @Published var repos: [GitRepoEntity] = []
    private let fetchRepos: FetchReposUseCaseProtocol
    private var currentPage = 1

    init(fetchRepos: FetchReposUseCaseProtocol) {
        self.fetchRepos = fetchRepos
    }

    func loadMore() async {
        let new = try? await fetchRepos.execute(page: currentPage)
        if let new { repos.append(contentsOf: new) }
        currentPage += 1
    }
}
