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
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn() {
        isSigningIn = true
        
        authService.signIn().sink { [weak self] _ in
            self?.isSigningIn = false
        } receiveValue: { _ in }
        .store(in: &cancellables)
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
