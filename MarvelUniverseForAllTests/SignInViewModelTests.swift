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
        authService.signInSubject.send(completion: .finished)
        
        XCTAssertFalse(sut.isSigningIn)
    }
    
    func makeSut() -> (SignInViewModel, AuthServiceSpy) {
        let authService = AuthServiceSpy()
        let sut = SignInViewModel(authService: authService)
        
        return (sut, authService)
    }
}
