//
//  StartableCoordinatorSpy.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import UIKit

class StartableCoordinatorSpy: StartableCoordinator {
    var navController: UINavigationController?
    
    func start(navController: UINavigationController) {
        self.navController = navController
    }
}
