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
        let sut = makeSut()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
    
    func test_start_showsSettingsView() {
        let sut = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<SettingsView>)
    }
    
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> StartableCoordinator {
        let sut = SettingsCoordinator()
        trackForMemoryLeaks(sut)
        
        return sut
    }
}
