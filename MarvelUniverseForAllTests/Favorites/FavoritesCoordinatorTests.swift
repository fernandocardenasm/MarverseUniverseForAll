//
//  FavoritesCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import SwiftUI
import XCTest

class FavoritesCoordinator {
    
    public weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: FavoritesView()), animated: true)
    }
}

public struct FavoritesView: View {
    
    public var body: some View {
        Text("Favorites View")
    }
}

class FavoritesCoordinatorTests: XCTest {
    
    func test_init_doesNotInitNavController() {
        let sut = FavoritesCoordinator()
        
        XCTAssertNil(sut.navController)
    }
    
    func test_start_setsNavController() {
        let sut = FavoritesCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(sut.navController, navController)
    }
    
    func test_start_showsFavoritesView() {
        let sut = FavoritesCoordinator()
        
        let navController = UINavigationController()
        sut.start(navController: navController)
        
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers[0] is UIHostingController<FavoritesView>)
    }
}
