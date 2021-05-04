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
    
    private lazy var signInViewModel: SignInViewModel = {
        signInViewController.rootView.viewModel
    }()
    
    public init(signInViewController: UIHostingController<SignInView>) {
        self.signInViewController = signInViewController
    }
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.viewControllers.insert(signInViewController, at: 0)
        navController.popToRootViewController(animated: true)
        
        signInViewModel.signInFinishedSubject.sink { [weak self] _ in
            self?.finishedSubject.send(completion: .finished)
        }.store(in: &cancellables)
        
        signInViewModel.skipSignInSubject.sink { [weak self] _ in
            self?.finishedSubject.send(completion: .finished)
        }.store(in: &cancellables)
    }
    
    public func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
}
