//
//  SignInViewModelTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import MarvelUniverseForAll
import XCTest

class SignInViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_init_doesNotStartSigningIn() {
        let (sut, _) = makeSut()
        
        XCTAssertFalse(sut.isSigningIn)
    }
    
    func test_signIn_startsSigningIn() {
        let (sut, _) = makeSut()
        
        sut.signIn()
        
        XCTAssertTrue(sut.isSigningIn)
    }
    
    func test_signIn_onSignInFinished() {
        let (sut, authService) = makeSut()
        
        sut.signIn()
        
        let exp = expectation(description: "waiting to finish")
        
        sut.signInFinishedSubject.sink { _ in
            exp.fulfill()
        }.store(in: &cancellables)
        
        authService.signInSubject.send(completion: .finished)
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertFalse(sut.isSigningIn)
    }
    
    func makeSut() -> (SignInViewModel, AuthServiceSpy) {
        let authService = AuthServiceSpy()
        let sut = SignInViewModel(authService: authService)
        
        return (sut, authService)
    }
}
