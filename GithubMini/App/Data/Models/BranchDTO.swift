//
//  BranchDTO.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct BranchDTO: Decodable {
    let name: String

    func mapToEntity() -> BranchEntity {
        BranchEntity(name: name)
    }
}
