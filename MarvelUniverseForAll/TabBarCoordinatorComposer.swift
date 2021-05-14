//
//  TabBarCoordinatorComposer.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import Foundation

class TabBarCoordinatorComposer {
    
    private init() {}
    
    static func composed() -> TabBarCoordinator {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: TabBarController(),
                                                  homeCoordinator: HomeCoordinator(),
                                                  eventsCoordinator: EventsCoordinator(),
                                                  settingsCoordinator: SettingsCoordinator())
        return tabBarCoordinator
    }
}
