//
//  TabBarController.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import UIKit

public class TabBarController: UITabBarController {
    
    public private(set) lazy var homeNavController: UINavigationController = UINavigationController()
    public private(set) lazy var settingsNavController: UINavigationController = UINavigationController()
    
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
