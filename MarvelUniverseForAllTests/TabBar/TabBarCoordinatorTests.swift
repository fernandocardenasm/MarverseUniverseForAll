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
    
    func test_start_startsFavoritesCoordinator() {
        let (sut, args) = makeSut()
        
        sut.start()
        
        XCTAssertEqual(sut.tabBarController.favoritesNavController, args.favoritesCoordinator.navController)
    }
    
    func test_start_startsEventsCoordinator() {
        let (sut, args) = makeSut()
        
        sut.start()
        
        XCTAssertEqual(sut.tabBarController.eventsNavController, args.eventsCoordinator.navController)
    }
    
    func test_start_startsSettingsCoordinator() {
        let (sut, args) = makeSut()
        
        sut.start()
        
        XCTAssertEqual(sut.tabBarController.settingsNavController, args.settingsCoordinator.navController)
    }
    
    private func makeSut() -> (sut: TabBarCoordinator,
                               args: (homeCoordinator: StartableCoordinator,
                                      favoritesCoordinator: StartableCoordinator,
                                      eventsCoordinator: StartableCoordinator,
                                      settingsCoordinator: StartableCoordinator)) {
        let tabBarController = TabBarController()
        let homeCoordinator = StartableCoordinatorSpy()
        let favoritesCoordinator = StartableCoordinatorSpy()
        let eventsCoordinator = StartableCoordinatorSpy()
        let settingsCoordinator = StartableCoordinatorSpy()
        let sut = TabBarCoordinator(tabBarController: tabBarController,
                                    homeCoordinator: homeCoordinator,
                                    favoritesCoordinator: favoritesCoordinator,
                                    eventsCoordinator: eventsCoordinator,
                                    settingsCoordinator: settingsCoordinator)
        return (sut, (homeCoordinator,
                      favoritesCoordinator,
                      eventsCoordinator,
                      settingsCoordinator))
    }
}

class StartableCoordinatorSpy: StartableCoordinator {
    var navController: UINavigationController?
    
    func start(navController: UINavigationController) {
        self.navController = navController
    }
}
