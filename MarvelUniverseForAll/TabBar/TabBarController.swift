//
//  TabBarController.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import UIKit

public class TabBarController: UITabBarController {
    
    public private(set) lazy var homeNavController: UINavigationController = UINavigationController()
    public private(set) lazy var favoritesNavController: UINavigationController = UINavigationController()
    public private(set) lazy var eventsNavController: UINavigationController = UINavigationController()
    public private(set) lazy var settingsNavController: UINavigationController = UINavigationController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        homeNavController.tabBarItem = TabBarItemFactory.home()
        favoritesNavController.tabBarItem = TabBarItemFactory.favorites()
        eventsNavController.tabBarItem = TabBarItemFactory.events()
        settingsNavController.tabBarItem = TabBarItemFactory.settings()
        
        viewControllers = [
            homeNavController,
            favoritesNavController,
            eventsNavController,
            settingsNavController
        ]
    }
}
