//
//  AuthService.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine

public protocol AuthService {
    func signIn() -> AnyPublisher<Void, Never>
}
