//
//  LoginAuthenticatorSpy.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import MarvelUniverseForAll

class LoginAuthenticatorSpy: LoginAuthenticator {
    
    let signInSubject = PassthroughSubject<Void, Error>()
    
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        signInSubject.eraseToAnyPublisher()
    }
}
