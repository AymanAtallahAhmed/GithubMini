//
//  BranchesListView.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import SwiftUI

struct BranchesListView: View {
//    let owner: String
//    let repo: String
    @StateObject var viewModel: BranchesListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.branches) { branch in
                Text(branch.name)
                    .task { await viewModel.loadNextPageIfNeeded(force: false) }
            }

            if viewModel.isLoading {
                ProgressView().frame(maxWidth: .infinity)
            }

            if let error = viewModel.error {
                Text(error).foregroundColor(.red)
            }
        }
        .navigationTitle(viewModel.title)
        .task { await viewModel.loadNextPageIfNeeded(force: true) }
    }
}

//#Preview {
//    BranchesListView()
//}
