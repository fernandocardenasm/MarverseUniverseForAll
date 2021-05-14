//
//  FavoritesCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import SwiftUI
import XCTest

class FavoritesCoordinator {
    
    public weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
    }
}

class FavoritesCoordinatorTests: XCTest {
    
    func test_init_doesNotInitNavController() {
        let sut = FavoritesCoordinator()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = FavoritesCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
}
