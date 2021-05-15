//
//  EventsCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import SwiftUI
import XCTest

class EventsCoordinatorTests: XCTestCase {
    
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
    
    func test_start_showsEventsView() {
        let sut = makeSut()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<EventsView>)
    }
    
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> StartableCoordinator {
        let sut = EventsCoordinator()
        trackForMemoryLeaks(sut)
        
        return sut
    }
}
