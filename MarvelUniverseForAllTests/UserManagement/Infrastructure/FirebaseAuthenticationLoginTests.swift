//
//  FirebaseAuthServiceTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import Firebase
import MarvelUniverseForAll
import XCTest

class FirebaseAuthenticationLoginTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        setupLocalEmulator()
        setupEmptyAccountsStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoAccountsStoreSideEffects()
    }
    
    func test_signIn_succeedsOnValidEmailAndPassword() {
        let sut = FirebaseAuthenticationLogin(authenticator: Auth.auth())
        
        let email = "signInvalidEmail2@email.com"
        let password = "StrongPassword123"
        addAccountInStore(email: email, password: password)
        
        let exp = expectation(description: "waiting for signing in user")
        
        sut.signIn(email: email, password: password).sink { result in
            if case .finished = result {
                exp.fulfill()
            } else {
                XCTFail("the sign in method should have succeeded")
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_signIn_failsOnInvalidEmail() {
        let sut = FirebaseAuthenticationLogin(authenticator: Auth.auth())
        
        let invalidEmail = "afb.invalid"
        let password = "StrongPassword123"
        
        let exp = expectation(description: "waiting for signing in user")
        
        sut.signIn(email: invalidEmail, password: password).sink { result in
            if case .failure = result {
                exp.fulfill()
            } else {
                XCTFail("the sign in method should have failed with the invalid email :\(invalidEmail)")
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
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
