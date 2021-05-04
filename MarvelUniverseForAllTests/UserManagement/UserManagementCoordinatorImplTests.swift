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
        let (sut, _, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
                
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertEqual(navController.viewControllers.first, signInViewController)
    }
    
    func test_start_completesCoordinatorAfterSignInFinished() {
        let (sut, _, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        signInViewController.rootView.viewModel.signInFinishedSubject.send(())
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_start_completesCoordinatorAfterSkippingSignIn() {
        let (sut, _, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        signInViewController.rootView.viewModel.skipSignInSubject.send(())
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func makeSut() -> (UserManagementCoordinator, AuthServiceSpy, UIHostingController<SignInView>) {
        let authService = AuthServiceSpy()
        let signInViewController = makeSignInViewController(authService: authService)
        let sut = UserManagementCoordinatorImpl(signInViewController: signInViewController)
        
        return (sut, authService, signInViewController)
    }
    
    func makeSignInViewController(authService: AuthService) -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel(authService: authService)
        let signInView = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: signInView)
    }
}
