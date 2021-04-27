//
//  AppCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import UIKit

protocol AuthService {
    
    func signIn() -> AnyPublisher<Void, Never>
}

class UserManagementCoordinator {
    
    var cancellables = Set<AnyCancellable>()
    let finishedSubject = PassthroughSubject<Void, Never>()
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func start(navController: UINavigationController) {
        authService.signIn().sink { _ in
            print("User logged In")
        }.store(in: &cancellables)
    }
    
    func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
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
        userManagementCoordinator.start(navController: navController)
        
        userManagementCoordinator.finished().sink { _ in
            print("User Management Finished")
        }.store(in: &cancellables)
    }
}
