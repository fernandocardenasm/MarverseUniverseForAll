//
//  SignInViewModelTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import MarvelUniverseForAll
import XCTest

class SignInViewModel: ObservableObject {
    
    @Published var isSigningIn: Bool = false
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn() {
        isSigningIn = true
    }
}


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
    
    func makeSut() -> (SignInViewModel, AuthService) {
        let authService = AuthServiceSpy()
        let sut = SignInViewModel(authService: authService)
        
        return (sut, authService)
    }
}
