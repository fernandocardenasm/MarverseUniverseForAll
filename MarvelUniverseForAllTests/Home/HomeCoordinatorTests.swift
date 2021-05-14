//
//  HomeCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import XCTest

class HomeCoordinatorTests: XCTestCase {
    
    func test_init_doesNotInitNavController() {
        let sut = HomeCoordinator()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = HomeCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
}
