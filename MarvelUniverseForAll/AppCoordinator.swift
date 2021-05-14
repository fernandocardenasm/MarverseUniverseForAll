//
//  AppCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

public class AppCoordinator {
    
    public private(set) lazy var navController = UINavigationController()
    public private(set) lazy var rootViewController: UIViewController = navController
    
    var cancellables = Set<AnyCancellable>()
    
    private let userManagementCoordinator: UserManagementCoordinator
    private let tabBarCoordinator: TabBarCoordinator
    
    public init(userManagementCoordinator: UserManagementCoordinator,
                tabBarCoordinator: TabBarCoordinator) {
        self.userManagementCoordinator = userManagementCoordinator
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    public func onAppStart() {
        userManagementCoordinator.finished().sink(receiveCompletion: { [weak self] receive in
            self?.setTabBarControllerAsRootViewController()
            self?.tabBarCoordinator.start()
        }, receiveValue: { _ in }).store(in: &cancellables)
        
        userManagementCoordinator.start(navController: navController)
    }
    
    private func setTabBarControllerAsRootViewController() {
        UIView.transition(from: rootViewController.view,
                          to: tabBarCoordinator.tabBarController.view,
                          duration: 0.2,
                          options: [.transitionCrossDissolve]) { _ in
            self.rootViewController = self.tabBarCoordinator.tabBarController
        }
    }
}

public protocol StartableCoordinator {
    var navController: UINavigationController? { get }
    
    func start(navController: UINavigationController)
}
