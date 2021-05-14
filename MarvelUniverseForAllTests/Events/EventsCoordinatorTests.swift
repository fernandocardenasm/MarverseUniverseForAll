//
//  EventsCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import XCTest

public class EventsCoordinator {
    
    weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
    }
}

class EventsCoordinatorTests: XCTestCase {
    
    func test_init_doesNotInitNavController() {
        let sut = EventsCoordinator()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = EventsCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
}
