//
//  UserManagementCoordinatorImplTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 03.05.21.
//

import Combine
import MarvelUniverseForAll
import SwiftUI
import XCTest

class UserManagementCoordinatorImplTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_start_showsSignInView() {
        let (sut, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
                
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertEqual(navController.viewControllers.first, signInViewController)
    }
    
    func test_start_completesCoordinatorAfterSignInFinished() {
        let (sut, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        signInViewController.finishSignIn()
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_start_completesCoordinatorAfterSkippingSignIn() {
        let (sut, signInViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        signInViewController.finishSignIn()
        
        wait(for: [exp], timeout: 0.1)
    }
}

// MARK: - Helpers

private extension UserManagementCoordinatorImplTests {
    func makeSut() -> (UserManagementCoordinator, UIHostingController<SignInView>) {
        let loginAuthenticator = LoginAuthenticatorSpy()
        let signInViewController = makeSignInViewController(loginAuthenticator: loginAuthenticator)
        
        let userCreator = UserCreatorSpy()
        let signUpViewController = makeSignUpViewController(userCreator: userCreator)
        let sut = UserManagementCoordinatorImpl(signInViewController: signInViewController,
                                                signUpViewController: signUpViewController)
        
        return (sut, signInViewController)
    }
    
    func makeSignInViewController(loginAuthenticator: LoginAuthenticator) -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel(loginAuthenticator: loginAuthenticator)
        let signInView = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: signInView)
    }
    
    func makeSignUpViewController(userCreator: UserCreator) -> UIHostingController<SignUpView> {
        let viewModel = SignUpViewModel(userCreator: userCreator)
        let signInView = SignUpView(viewModel: viewModel)
        
        return UIHostingController(rootView: signInView)
    }
}

private extension UIHostingController where Content == SignInView {
    func finishSignIn() {
        rootView.viewModel.signInFinishedSubject.send(())
    }
}
