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
    
    func test_start_showsSignInView() {
        let (sut, _) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
                
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers.first is UIHostingController<SignInView>)
    }
    
    func makeSut() -> (UserManagementCoordinator, AuthServiceSpy) {
        let authService = AuthServiceSpy()
        let sut = UserManagementCoordinatorImpl(authService: authService)
        
        return (sut, authService)
    }
}

class AuthServiceSpy: AuthService {
    
    let signInSubject = PassthroughSubject<Void, Never>()
    
    func signIn() -> AnyPublisher<Void, Never> {
        signInSubject.eraseToAnyPublisher()
    }
}
