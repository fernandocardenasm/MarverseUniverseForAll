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
    
    public init(userManagementCoordinator: UserManagementCoordinator) {
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
