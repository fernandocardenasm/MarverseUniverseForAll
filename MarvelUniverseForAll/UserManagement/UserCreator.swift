//
//  UserCreator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Combine

public protocol UserCreator {
    func createUser(email: String, password: String) -> AnyPublisher<String, Error>
}
