//
//  FavoritesCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import XCTest

class FavoritesCoordinator {
    public weak var navController: UINavigationController?
    
    public init() {}
}

class FavoritesCoordinatorTests: XCTest {
    
    func test_init_doesNotInitNavController() {
        let sut = FavoritesCoordinator()
        
        XCTAssertNil(sut.navController)
    }
}
