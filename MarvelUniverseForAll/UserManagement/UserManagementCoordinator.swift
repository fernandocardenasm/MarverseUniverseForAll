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
    
    private let authService: AuthService
    private var navController: UINavigationController?
    
    public init(authService: AuthService) {
        self.authService = authService
    }
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.viewControllers.insert(signInViewController(), at: 0)
        navController.popToRootViewController(animated: true)
        
        authService.signIn().sink { [weak self] _ in
            print("User logged In")
            self?.finishedSubject.send(completion: .finished)
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    public func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
    
    func signInViewController() -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel()
        let view = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
