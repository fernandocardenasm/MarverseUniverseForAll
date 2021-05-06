//
//  FirebaseUserCreatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Firebase
import MarvelUniverseForAll
import XCTest



class FirebaseUserCreatorTests: XCTestCase {
    
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
        sut.createUser(email: "validEmail2@email.com", password: "StrongPassword123") { result in
            switch result {
            case .success:
                exp.fulfill()
            case .failure:
                XCTFail("create user should not fail")
            }
        }
        
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
