//
//  DeviceCodeResponse.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct DeviceCodeResponse: Decodable {
    let device_code: String
    let user_code: String
    let verification_uri: String
    let interval: Int
}
