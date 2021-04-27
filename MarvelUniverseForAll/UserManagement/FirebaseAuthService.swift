//
//  FirebaseAuthService.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine

class FirebaseAuthService: AuthService {
    func signIn() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
