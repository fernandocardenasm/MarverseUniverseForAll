//
//  AppCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

class UserManagementCoordinator {
    
    var cancellables = Set<AnyCancellable>()
    let finishedSubject = PassthroughSubject<Void, Never>()
    
    private let authService: AuthService
    private var navController: UINavigationController?
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.viewControllers.insert(signInViewController(), at: 0)
        navController.popToRootViewController(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.authService.signIn().sink { [weak self] _ in
                print("User logged In")
                self?.finishedSubject.send(completion: .finished)
            }.store(in: &self.cancellables)
        }
    }
    
    func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
    
    func signInViewController() -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel()
        let view = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}

class AppCoordinator {
    
    lazy var navController = UINavigationController()
    lazy var rootViewController: UIViewController = navController
    
    var cancellables = Set<AnyCancellable>()
    
    let userManagementCoordinator: UserManagementCoordinator
    
    init(userManagementCoordinator: UserManagementCoordinator) {
        self.userManagementCoordinator = userManagementCoordinator
    }
    
    func onAppStart() {
        userManagementCoordinator.finished().sink(receiveCompletion: { [weak self] receive in
            print("Completion")
            
            guard let self = self else { return }
            
            self.navController.viewControllers.insert(UIHostingController(rootView: TabBarView()), at: 0)
            self.navController.popToRootViewController(animated: true)
            
        }, receiveValue: { _ in }).store(in: &cancellables)
        
        userManagementCoordinator.start(navController: navController)
    }
    
    func tabBarViewController() -> UIHostingController<HomeView> {
        UIHostingController(rootView: HomeView())
    }
}
