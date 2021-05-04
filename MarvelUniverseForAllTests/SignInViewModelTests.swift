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
    
    let signInSubject = PassthroughSubject<Void, Never>()
    let skipSignInSubject = PassthroughSubject<Void, Never>()
    
    func signIn() {
        isSigningIn = true
    }
}


class SignInViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_init_doesNotStartSigningIn() {
        let sut = SignInViewModel()
        XCTAssertFalse(sut.isSigningIn)
    }
    
    func test_signIn_startsSigningIn() {
        let sut = SignInViewModel()
        
        sut.signIn()
        
        XCTAssertTrue(sut.isSigningIn)
    }
}
