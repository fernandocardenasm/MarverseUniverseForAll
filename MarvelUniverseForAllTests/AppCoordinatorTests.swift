//
//  AppCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 29.04.21.
//

import Combine
import MarvelUniverseForAll
import XCTest

class AppCoordinatorTests: XCTestCase {
    
    func test_init_doesNotPushViews() {
        let userManagementCoordinator = UserManagementCoordinatorSpy()
        let sut = AppCoordinator(userManagementCoordinator: userManagementCoordinator)
        
        XCTAssertEqual(sut.navController, sut.rootViewController)
    }
    
    func test_onAppStart_starts_userManagementCoordinator() {
        let userManagementCoordinator = UserManagementCoordinatorSpy()
        let sut = AppCoordinator(userManagementCoordinator: userManagementCoordinator)
        
        sut.onAppStart()
        
        XCTAssertEqual(userManagementCoordinator.startedNavController, sut.navController)
    }
}

class UserManagementCoordinatorSpy: UserManagementCoordinator {
    
    var startedNavController: UINavigationController?
    
    func start(navController: UINavigationController) {
        startedNavController = navController
    }
    
    func finished() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
