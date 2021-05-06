//
//  FirebaseAuthServiceTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Firebase
import MarvelUniverseForAll
import XCTest

class FirebaseAuthService {
    
    private let authenticator: Auth
    
    init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authenticator.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let _ = authResult {
                completion(.success(()))
            }
        }
    }
}

class FirebaseAuthServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupLocalEmulator()
        setupEmptyAccountsStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoAccountsStoreSideEffects()
    }
    
    func test_signIn_onSuccess() {
        let sut = FirebaseAuthService(authenticator: Auth.auth())
        
        let email = "signInvalidEmail2@email.com"
        let password = "StrongPassword123"
        addAccountInStore(email: email, password: password)
        
        let exp = expectation(description: "waiting for creating user")
        
        sut.signIn(email: email, password: password) { _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func setupLocalEmulator() {
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
    }
    
    private func setupEmptyAccountsStoreState() {
        Auth.deleteAccountsArtifacts()
    }
    
    private func undoAccountsStoreSideEffects() {
        Auth.deleteAccountsArtifacts()
    }
    
    private func addAccountInStore(email: String, password: String) {
        let exp = expectation(description: "waiting for adding account")
        Auth.auth().createUser(withEmail: email, password: password) { dataResult, error in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}
