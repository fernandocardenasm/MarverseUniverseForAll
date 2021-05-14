//
//  SettingsCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import XCTest

class SettingsCoordinatorTests: XCTestCase {
    
    func test_init_doesNotInitNavController() {
        let sut = SettingsCoordinator()
        
        XCTAssertNil(sut.navController)
    }
}
