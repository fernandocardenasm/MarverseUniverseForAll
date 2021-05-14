//
//  TabBarCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import Foundation

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
