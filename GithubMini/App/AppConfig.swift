//
//  AppConfig.swift
//  GithubMini
//
//  Created by Ayman on 28/08/2025.
//

import Foundation

final class AppConfig {
    var githubClientID: String {
        Bundle.main.object(forInfoDictionaryKey: "GitHubClientID") as? String ?? ""
    }
}
