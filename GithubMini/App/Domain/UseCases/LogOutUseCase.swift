//
//  LogOutUseCase.swift
//  GithubMini
//
//  Created by Ayman on 27/08/2025.
//

import Foundation

protocol LogoutUseCaseProtocol {
    func execute() async
}

struct LogoutUseCase: LogoutUseCaseProtocol {
    let authRepository: AuthRepoProtocol

    init(authRepository: AuthRepoProtocol) {
        self.authRepository = authRepository
    }

    func execute() async {
        await authRepository.logout()
    }
}
