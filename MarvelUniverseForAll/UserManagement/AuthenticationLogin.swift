//
//  AuthenticationLogin.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Combine
import Foundation

public protocol AuthenticationLogin {
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
}
