//
//  AuthFlowDTO.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct AuthFlowDTO: Decodable {
    let device_code: String
    let user_code: String
    let verification_uri: String
    let interval: Int
    let expiresIn: Int?

    func mapToEntity() -> AuthFlowEntity {
        AuthFlowEntity(
            deviceCode: device_code,
            userCode: user_code,
            verificationURI: verification_uri,
            interval: interval,
            expiresIn: expiresIn
        )
    }
}
