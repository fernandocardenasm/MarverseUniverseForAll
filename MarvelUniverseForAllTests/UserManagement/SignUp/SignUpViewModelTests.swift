//
//  SignUpViewModelTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 11.05.21.
//

import Combine
import MarvelUniverseForAll
import XCTest

class SignUpViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_init_doesNotStartSigningUp() {
        let (sut, _) = makeSut()
        
        XCTAssertFalse(sut.isSigningUp)
    }
    
    func test_signIn_startsSigningUp() {
        let (sut, _) = makeSut()
        
        sut.signup()
        
        XCTAssertTrue(sut.isSigningUp)
    }
    
    func test_signUn_onSignUpFinished() {
        let (sut, userCreator) = makeSut()
        
        sut.signup()
        
        let exp = expectation(description: "waiting to finish")
        
        sut.signUpFinishedSubject.sink { _ in
            exp.fulfill()
        }.store(in: &cancellables)
        
        userCreator.createUserSubject.send(completion: .finished)
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertFalse(sut.isSigningUp)
    }
    
    func test_skipSignUp_sendsOnSignUnFinished() {
        let (sut, _) = makeSut()
        
        let exp = expectation(description: "waiting to finish")
        
        sut.signUpFinishedSubject.sink { _ in
            exp.fulfill()
        }.store(in: &cancellables)
        
        sut.skipSignUp()
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func makeSut() -> (SignUpViewModel, UserCreatorSpy) {
        let userCreator = UserCreatorSpy()
        let sut = SignUpViewModel(userCreator: userCreator)
        
        return (sut, userCreator)
    }
}
