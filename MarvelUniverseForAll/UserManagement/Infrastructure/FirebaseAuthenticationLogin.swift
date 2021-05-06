//
//  FirebaseAuthenticationLogin.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import FirebaseAuth
import Foundation

public class FirebaseAuthenticationLogin {
    
    private let authenticator: Auth
    
    public init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authenticator.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let _ = authResult {
                completion(.success(()))
            }
        }
    }
}
