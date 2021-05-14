//
//  StartableCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import UIKit

public protocol StartableCoordinator {
    var navController: UINavigationController? { get }
    
    func start(navController: UINavigationController)
}
