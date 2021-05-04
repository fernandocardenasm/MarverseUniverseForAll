//
//  UserManagementCoordinatorImplTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 03.05.21.
//

import Combine
import Foundation
import MarvelUniverseForAll
import SwiftUI
import XCTest

class UserManagementCoordinatorImplTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_start_showsSignInView() {
        let (sut, _) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
                
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers.first is UIHostingController<SignInView>)
    }
    
    func test_start_completesCoordinatorAfterAuthServiceCompletes() {
        let (sut, authService) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        authService.signInSubject.send(completion: .finished)
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func makeSut() -> (UserManagementCoordinator, AuthServiceSpy) {
        let authService = AuthServiceSpy()
        let sut = UserManagementCoordinatorImpl(authService: authService)
        
        return (sut, authService)
    }
}
