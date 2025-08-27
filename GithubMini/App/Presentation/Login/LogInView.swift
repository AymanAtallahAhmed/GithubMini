//
//  LogInView.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var container: AppContainer
    @ObservedObject var viewModel: LogInViewModel
    @State private var navigateToRepos = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "octagon")
                .font(.system(size: 64))
                .padding(.top, 40)
            Text("Mini GitHub")
                .font(.largeTitle.bold())
            Text("Sign in to view your repositories (including private)")
                .foregroundStyle(.secondary)
            Button(action: { viewModel.startLogin() }) {
                Label("Sign in with GitHub", systemImage: "person.crop.circle.badge.checkmark")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
            
            switch viewModel.state {
            case .idle, .loading, .error:
                Text("\(viewModel.state)")
                    .font(.title)
                //Show alert here with given state
            case .waitingForUser:
                //Show alert here with given state
                Text("\(viewModel.state)")
                    .font(.title)
            case .loggedIn:
                Text("Navigating to repositories...")
                    .task {
                        navigateToRepos = true
                    }
            }
        }
        .padding()
        .navigationDestination(isPresented: $navigateToRepos) {
            ReposListView(viewModel: .init(fetchRepos: container.fetchReposUseCase)) // your repo list screen
        }
    }
}

//#Preview {
//    LogInView()
//}
