//
//  AuthFlowEntity.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct AuthFlowEntity {
    let deviceCode: String
    let userCode: String
    let verificationURI: String
    let interval: Int
    let expiresIn: Int?
}
