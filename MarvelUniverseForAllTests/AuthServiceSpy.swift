//
//  AuthServiceSpy.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import MarvelUniverseForAll

class AuthServiceSpy: AuthService {
    
    let signInSubject = PassthroughSubject<Void, Never>()
    
    func signIn() -> AnyPublisher<Void, Never> {
        signInSubject.eraseToAnyPublisher()
    }
}
