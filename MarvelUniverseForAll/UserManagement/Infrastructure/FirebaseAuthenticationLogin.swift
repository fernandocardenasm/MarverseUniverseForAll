//
//  FirebaseAuthenticationLogin.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Combine
import FirebaseAuth
import Foundation

public class FirebaseAuthenticationLogin: LoginAuthenticator {
    
    private let authenticator: Auth
    
    public init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    public func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                self?.authenticator.signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let _ = authResult {
                        promise(.success(()))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
