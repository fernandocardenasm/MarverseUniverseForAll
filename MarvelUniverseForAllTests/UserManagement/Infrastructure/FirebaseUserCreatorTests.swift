//
//  FirebaseUserCreatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Combine
import Firebase
import MarvelUniverseForAll
import XCTest

class FirebaseUserCreatorTests: XCTestCase {
    
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
    
    func test_createUser_onSuccess() {
        let sut = FirebaseUserCreator(authenticator: Auth.auth())
        
        let exp = expectation(description: "waiting for creating user")
        sut.createUser(email: "validEmail2@email.com", password: "StrongPassword123").sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func setupLocalEmulator() {
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
    }
    
    private func setupEmptyAccountsStoreState() {
        Auth.deleteAccountsArtifacts()
    }
    
    private func undoAccountsStoreSideEffects() {
        Auth.deleteAccountsArtifacts()
    }
}
