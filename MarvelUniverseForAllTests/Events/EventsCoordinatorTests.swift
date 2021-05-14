//
//  EventsCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import SwiftUI
import XCTest

public class EventsCoordinator {
    
    weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: EventsView()), animated: true)
    }
}

public struct EventsView: View {
    
    public var body: some View {
        Text("Events Viwe")
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
    
    func test_start_showsEventsView() {
        let sut = EventsCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<EventsView>)
    }
}
