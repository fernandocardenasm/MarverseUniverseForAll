//
//  InMemoryUserCreator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import Combine

class InMemoryUserCreator: UserCreator {
    func createUser(email: String, password: String) -> AnyPublisher<String, Error> {
        Deferred {
            Future { promise in
                promise(.success("some user Id"))
            }
        }.eraseToAnyPublisher()
    }
}
