//
//  AppCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 29.04.21.
//

import Combine
import MarvelUniverseForAll
import SwiftUI
import XCTest

class AppCoordinatorTests: XCTestCase {
    
    func test_init_doesNotPushViews() {
        let (sut, _) = makeSut()
        
        XCTAssertEqual(sut.navController.viewControllers.count, 0)
    }
    
    func test_init_rootViewControllerIsNavController() {
        let (sut, _) = makeSut()
        
        XCTAssertEqual(sut.navController, sut.rootViewController)
    }
    
    func test_onAppStart_starts_userManagementCoordinator() {
        let (sut, userMgtCoord) = makeSut()
        
        sut.onAppStart()
        
        XCTAssertEqual(userMgtCoord.startedNavController, sut.navController)
    }
    
    func test_onAppStart_showsTabBar_afterUserManagementCoordinatorCompletes() {
        let (sut, userMgtCoord) = makeSut()
        
        sut.onAppStart()
        
        userMgtCoord.finishedSubject.send(completion: .finished)
        
        XCTAssertEqual(sut.navController.viewControllers.count, 1)
        XCTAssertTrue(sut.navController.viewControllers.first is UIHostingController<TabBarView>)
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
    
    var finishedSubject = PassthroughSubject<Void, Never>()
    
    func finished() -> AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
}
