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
}

class EventsCoordinatorTests: XCTestCase {
    
    func test_init_doesNotInitNavController() {
        let sut = EventsCoordinator()
        
        XCTAssertNil(sut.navController)
    }
}
