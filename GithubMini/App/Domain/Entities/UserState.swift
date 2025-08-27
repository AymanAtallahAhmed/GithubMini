//
//  UserState.swift
//  GithubMini
//
//  Created by Ayman on 28/08/2025.
//

import Foundation

enum UserState {
    case idle
    case loading
    case waitingForUser(code: String, url: String)
    case loggedIn
    case error(String)
}
