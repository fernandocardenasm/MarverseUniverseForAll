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
}

class UserManagementCoordinatorSpy: UserManagementCoordinator {
    
    func start(navController: UINavigationController) {
    }
    
    func finished() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
