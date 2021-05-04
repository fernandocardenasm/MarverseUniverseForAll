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

class FirebaseAuthService: AuthService {
    
    private let authenticator: Auth
    
    init(authenticator: Auth) {
        self.authenticator = authenticator
    }
    
    func signIn() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        authenticator.createUser(withEmail: email, password: password) { dataResult, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
            } else if let dataResult = dataResult {
                completion(.success(dataResult.user.uid))
                print("DataResult_ \(dataResult.user.uid)")
            }
        }
    }
}

class FirebaseAuthServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        clearAccounts()
    }
    
    override func tearDown() {
        super.tearDown()
        
        clearAccounts()
    }
    
    func test_createUser_onSuccess() {
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        
        let sut = FirebaseAuthService(authenticator: Auth.auth())
        
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
    
    // MARK: - Helpers
    
    private func clearAccounts() {
        let semaphore = DispatchSemaphore(value: 0)
        let projectId = FirebaseApp.app()!.options.projectID!
        let url = URL(string: "http://localhost:9099/emulator/v1/projects/\(projectId)/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { _,_,_ in
            print("Firestore cleared")
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
