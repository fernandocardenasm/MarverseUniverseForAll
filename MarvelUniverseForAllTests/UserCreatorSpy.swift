//
//  UserCreatorSpy.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 10.05.21.
//

import Combine
import MarvelUniverseForAll

class UserCreatorSpy: UserCreator {
    
    let createUserSubject = PassthroughSubject<String, Error>()
    
    func createUser(email: String, password: String) -> AnyPublisher<String, Error> {
        createUserSubject.eraseToAnyPublisher()
    }
}
