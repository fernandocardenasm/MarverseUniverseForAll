//
//  FirebaseUserCreatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Firebase
import MarvelUniverseForAll
import XCTest

class FirebaseUserCreator {
    private let authenticator: Auth
    
    init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        authenticator.createUser(withEmail: email, password: password) { dataResult, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
            } else if let dataResult = dataResult {
                completion(.success(dataResult.user.uid))
                print("DataResult: \(dataResult.user.uid)")
            }
        }
    }
}

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
