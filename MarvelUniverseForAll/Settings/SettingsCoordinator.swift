//
//  SettingsCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import SwiftUI

public class SettingsCoordinator {
    
    public weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: SettingsView()), animated: true)
    }
}
