//
//  TabBarCoordinatorTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import XCTest

class TabBarCoordinatorTests: XCTestCase {
    
    func test_init_doesNotStartHomeCoordinator() {
        let (sut, args) = makeSut()
        
        XCTAssertNotEqual(sut.tabBarController.homeNavController,
                          args.homeCoordinator.navController)
    }
    
    func test_init_doesNotStartSettingsCoordinator() {
        let (sut, args) = makeSut()
        
        XCTAssertNotEqual(sut.tabBarController.settingsNavController,
                          args.settingsCoordinator.navController)
    }
    
    func test_start_startsHomeCoordinator() {
        let (sut, args) = makeSut()
        
        sut.start()
        
        XCTAssertEqual(sut.tabBarController.homeNavController, args.homeCoordinator.navController)
    }
    
    func test_start_startsSettingsCoordinator() {
        let (sut, args) = makeSut()
        
        sut.start()
        
        XCTAssertEqual(sut.tabBarController.settingsNavController, args.settingsCoordinator.navController)
    }
    
    private func makeSut() -> (sut: TabBarCoordinator,
                       (homeCoordinator: HomeCoordinator,
                       settingsCoordinator: SettingsCoordinator)) {
        let tabBarController = TabBarController()
        let homeCoordinator = HomeCoordinator()
        let settingsCoordinator = SettingsCoordinator()
        let sut = TabBarCoordinator(tabBarController: tabBarController,
                                    homeCoordinator: homeCoordinator, settingsCoordinator: settingsCoordinator)
        return (sut, (homeCoordinator, settingsCoordinator))
    }
}