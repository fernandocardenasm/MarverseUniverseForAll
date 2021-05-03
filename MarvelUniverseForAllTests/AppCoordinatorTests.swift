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
        let (sut, _) = makeSut()
        
        XCTAssertEqual(sut.navController, sut.rootViewController)
    }
    
    func test_onAppStart_starts_userManagementCoordinator() {
        let (sut, userMgtCoord) = makeSut()
        
        sut.onAppStart()
        
        XCTAssertEqual(userMgtCoord.startedNavController, sut.navController)
    }
    
}

// MARK: - Helpers

extension AppCoordinatorTests {
    
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (AppCoordinator, UserManagementCoordinatorSpy) {
        let userManagementCoordinator = UserManagementCoordinatorSpy()
        let sut = AppCoordinator(userManagementCoordinator: userManagementCoordinator)
        return (sut, userManagementCoordinator)
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
