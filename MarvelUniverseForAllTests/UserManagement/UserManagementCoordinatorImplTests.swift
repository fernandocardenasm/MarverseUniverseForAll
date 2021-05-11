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
        let (sut, signInViewController, _) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
                
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertEqual(navController.viewControllers.first, signInViewController)
    }
    
    func test_start_completesCoordinatorAfterSignInFinished() {
        let (sut, signInViewController, _) = makeSut()
        
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
    
    func test_start_completesCoordinatorAfterSignUpFinished() {
        let (sut, _, signUpViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)

        let exp = expectation(description: "waiting to finish")
        sut.finished().sink { _ in
            exp.fulfill()
        } receiveValue: { _ in }
        .store(in: &cancellables)
        
        signUpViewController.finishSignUp()
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_start_showsSignUpViewAfterSignUpStarted() {
        let (sut, signInViewController, signUpViewController) = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        signInViewController.startSignUp()
        enforceLayoutCycle()
        
        XCTAssertEqual(navController.viewControllers.count, 2)
        XCTAssertEqual(navController.viewControllers[0], signInViewController)
        XCTAssertEqual(navController.viewControllers[1], signUpViewController)
    }
}

// MARK: - Helpers

private extension UserManagementCoordinatorImplTests {
    func makeSut() -> (UserManagementCoordinator,
                       UIHostingController<SignInView>,
                       UIHostingController<SignUpView>) {
        let loginAuthenticator = LoginAuthenticatorSpy()
        let signInViewController = makeSignInViewController(loginAuthenticator: loginAuthenticator)
        
        let userCreator = UserCreatorSpy()
        let signUpViewController = makeSignUpViewController(userCreator: userCreator)
        let sut = UserManagementCoordinatorImpl(signInViewController: signInViewController,
                                                signUpViewController: signUpViewController)
        
        return (sut, signInViewController, signUpViewController)
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
    
    private func enforceLayoutCycle() {
        RunLoop.current.run(until: Date())
    }
}

private extension UIHostingController where Content == SignInView {
    func finishSignIn() {
        rootView.viewModel.signInFinishedSubject.send(())
    }
    
    func startSignUp() {
        rootView.viewModel.startSignUpSubject.send(())
    }
}

private extension UIHostingController where Content == SignUpView {
    func finishSignUp() {
        rootView.viewModel.signUpFinishedSubject.send(())
    }
}
