//
//  SettingsCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import SwiftUI
import XCTest

class SettingsCoordinatorTests: XCTestCase {
    
    func test_init_doesNotInitNavController() {
        let sut = SettingsCoordinator()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = SettingsCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
    
    func test_start_showsSettingsView() {
        let sut = SettingsCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<SettingsView>)
    }
}
