//
//  InMemoryLoginAuthenticator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import Combine

class InMemoryLoginAuthenticator: LoginAuthenticator {
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}
