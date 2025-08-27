//
//  ReposListView.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import SwiftUI
import Networking
import SecureStorage

struct ReposListView: View {
    @StateObject var viewModel: ReposListViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.repos) { repo in
                NavigationLink(repo.name, destination: BranchesListView(
                    viewModel: .init(
                        repo: repo,
                        fetchBranches: FetchBranchesUseCase(repository: GitHubRepositoriesRepo(
                            network: NetworkingManager(),
                            secureDataManger: SecureDataManager()
                        )
                        )
                    )
                )
                )
            }
            .task { await viewModel.loadMore() }
        }
    }
}

//#Preview {
//    ReposListView()
//}
