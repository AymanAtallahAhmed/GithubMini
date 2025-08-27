//
//  GitRepoDTO.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

struct GitRepoDTO: Decodable {
    let id: Int
    let name: String
    let language: String?
    let owner: OwnerDTO

    func mapToEntity() -> GitRepoEntity {
        GitRepoEntity(
            id: id,
            name: name,
            language: language
        )
    }
}
