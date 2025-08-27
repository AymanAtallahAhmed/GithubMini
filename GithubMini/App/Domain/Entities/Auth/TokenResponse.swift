//
//  TokenResponse.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct TokenResponse: Decodable {
    let access_token: String?
    let error: String?
}
