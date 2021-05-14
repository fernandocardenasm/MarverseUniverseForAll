//
//  TabBarCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import Foundation

public class TabBarCoordinator {
        
    public let tabBarController: TabBarController
    private let homeCoordinator: StartableCoordinator
    private let favoritesCoordinator: StartableCoordinator
    private let eventsCoordinator: StartableCoordinator
    private let settingsCoordinator: StartableCoordinator
    
    public init(tabBarController: TabBarController,
                homeCoordinator: StartableCoordinator,
                favoritesCoordinator: StartableCoordinator,
                eventsCoordinator: StartableCoordinator,
                settingsCoordinator: StartableCoordinator) {
        self.tabBarController = tabBarController
        self.homeCoordinator = homeCoordinator
        self.favoritesCoordinator = favoritesCoordinator
        self.eventsCoordinator = eventsCoordinator
        self.settingsCoordinator = settingsCoordinator
    }
    
    public func start() {
        homeCoordinator.start(navController: tabBarController.homeNavController)
        favoritesCoordinator.start(navController: tabBarController.favoritesNavController)
        eventsCoordinator.start(navController: tabBarController.eventsNavController)
        settingsCoordinator.start(navController: tabBarController.settingsNavController)
    }
}
