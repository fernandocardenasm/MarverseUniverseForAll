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
        
        setupEmptyAccountsStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoAccountsStoreSideEffects()
    }
    
    func test_createUser_onSuccess() {
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        
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
    
    private func setupEmptyAccountsStoreState() {
        deleteAccountsArtifacts()
    }
    
    private func undoAccountsStoreSideEffects() {
        deleteAccountsArtifacts()
    }
    
    private func deleteAccountsArtifacts() {
        let exp = expectation(description: "waiting to delete all accounts artifacts")
        let projectId = FirebaseApp.app()!.options.projectID!
        let url = URL(string: "http://localhost:9099/emulator/v1/projects/\(projectId)/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { _,_,_ in
            print("Firestore cleared")
            exp.fulfill()
        }
        task.resume()
        
        wait(for: [exp], timeout: 1.0)
    }
}
