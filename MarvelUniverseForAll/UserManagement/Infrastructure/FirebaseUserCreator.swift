//
//  FirebaseUserCreator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import FirebaseAuth

public class FirebaseUserCreator {
    private let authenticator: Auth
    
    public init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    public func createUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        authenticator.createUser(withEmail: email, password: password) { dataResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let dataResult = dataResult {
                completion(.success(dataResult.user.uid))
            }
        }
    }
}
