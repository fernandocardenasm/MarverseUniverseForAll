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
    private let eventsCoordinator: EventsCoordinator
    private let settingsCoordinator: SettingsCoordinator
    
    public init(tabBarController: TabBarController,
                homeCoordinator: HomeCoordinator,
                eventsCoordinator: EventsCoordinator,
                settingsCoordinator: SettingsCoordinator) {
        self.tabBarController = tabBarController
        self.homeCoordinator = homeCoordinator
        self.eventsCoordinator = eventsCoordinator
        self.settingsCoordinator = settingsCoordinator
    }
    
    public func start() {
        homeCoordinator.start(navController: tabBarController.homeNavController)
        eventsCoordinator.start(navController: tabBarController.eventsNavController)
        settingsCoordinator.start(navController: tabBarController.settingsNavController)
    }
}
