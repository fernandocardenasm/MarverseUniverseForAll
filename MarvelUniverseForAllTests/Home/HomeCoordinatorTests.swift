//
//  HomeCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import SwiftUI
import XCTest

class HomeCoordinatorTests: XCTestCase {
    
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
    
    func test_start_showsHomeView() {
        let sut = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<HomeView>)
    }
    
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> StartableCoordinator {
        let sut = HomeCoordinator()
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
