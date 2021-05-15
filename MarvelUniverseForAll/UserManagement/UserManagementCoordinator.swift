//
//  UserManagementCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 29.04.21.
//

import Combine
import SwiftUI

public protocol UserManagementCoordinator {
    func start(navController: UINavigationController)
    
    func finished() -> AnyPublisher<Void, Never>
}

public class UserManagementCoordinatorImpl: UserManagementCoordinator {
    
    private var cancellables = Set<AnyCancellable>()
    private let finishedSubject = PassthroughSubject<Void, Never>()
    
    private var navController: UINavigationController?
    private let signInViewController: UIHostingController<SignInView>
    private let signUpViewController: UIHostingController<SignUpView>
    
    private lazy var signInViewModel: SignInViewModel = {
        signInViewController.rootView.viewModel
    }()
    
    public init(signInViewController: UIHostingController<SignInView>,
                signUpViewController: UIHostingController<SignUpView>) {
        self.signInViewController = signInViewController
        self.signUpViewController = signUpViewController
    }
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(signInViewController, animated: true)
        
        signInViewModel.signInFinishedSubject.sink { [weak self] _ in
            self?.finishedSubject.send(completion: .finished)
        }.store(in: &cancellables)
        
        signInViewModel.startSignUpSubject.sink { [weak self] in
            self?.showSignUpView()
        }.store(in: &cancellables)
        
        signUpViewController.rootView.viewModel.signUpFinishedSubject.sink { [weak self] in
            self?.finishedSubject.send(completion: .finished)
        }.store(in: &cancellables)
    }
    
    public func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
    
    private func showSignUpView() {
        navController?.pushViewController(signUpViewController, animated: true)
    }
}
