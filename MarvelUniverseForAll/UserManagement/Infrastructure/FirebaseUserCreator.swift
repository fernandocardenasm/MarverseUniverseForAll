//
//  FirebaseUserCreator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Combine
import FirebaseAuth

public class FirebaseUserCreator: UserCreator {
    
    
    private let authenticator: Auth
    
    public init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    public func createUser(email: String, password: String) -> AnyPublisher<String, Error> {
        Deferred {
            Future { [weak self] promise in
                self?.authenticator.createUser(withEmail: email, password: password) { dataResult, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let dataResult = dataResult {
                        promise(.success(dataResult.user.uid))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
