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

public class TabBarCoordinator {
        
    public let tabBarController: TabBarController
    private let homeCoordinator: HomeCoordinator
    private let settingsCoordinator: SettingsCoordinator
    
    public init(tabBarController: TabBarController,
                homeCoordinator: HomeCoordinator,
                settingsCoordinator: SettingsCoordinator) {
        self.tabBarController = tabBarController
        self.homeCoordinator = homeCoordinator
        self.settingsCoordinator = settingsCoordinator
    }
    
    public func start() {
        homeCoordinator.start(navController: tabBarController.homeNavController)
        settingsCoordinator.start(navController: tabBarController.settingsNavController)
    }
}

public struct TabBarItemFactory {
    static func home() -> UITabBarItem {
        UITabBarItem(title: "Home",
                     image: UIImage(systemName: "house")!,
                     selectedImage: nil)
    }
    
    static func favorites() -> UITabBarItem {
        UITabBarItem(title: "Favorites",
                     image: UIImage(systemName: "heart")!,
                     selectedImage: nil)
    }
    
    static func events() -> UITabBarItem {
        UITabBarItem(title: "Events",
                     image: UIImage(systemName: "book")!,
                     selectedImage: nil)
    }
    
    static func settings() -> UITabBarItem {
        UITabBarItem(title: "Settings",
                     image: UIImage(systemName: "gearshape")!,
                     selectedImage: nil)
    }
}

public class TabBarController: UITabBarController {
    
    public let homeNavController: UINavigationController = UINavigationController()
    public let settingsNavController: UINavigationController = UINavigationController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        homeNavController.tabBarItem = TabBarItemFactory.home()
        settingsNavController.tabBarItem = TabBarItemFactory.settings()
        
        viewControllers = [
            homeNavController,
            settingsNavController
        ]
    }
}

public class HomeCoordinator {
    
    weak var navController: UINavigationController?
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: HomeView()), animated: true)
    }
}

public class SettingsCoordinator {
    
    weak var navController: UINavigationController?
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: SettingsView()), animated: true)
    }
}
