//
//  LogInView.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var viewModel: LogInViewModel
    
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
                EmptyView()
            case .waitingForUser(let code, let url):
                Text("case .waitingForUser(let code, let url):")
//                DeviceFlowView(code: code, url: url)
            case .loggedIn:
                EmptyView()
            }
        }
        .padding()
    }
}

//#Preview {
//    LogInView()
//}
