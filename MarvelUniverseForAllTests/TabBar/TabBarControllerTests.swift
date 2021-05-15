//
//  TabBarControllerTests.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 14.05.21.
//

import MarvelUniverseForAll
import XCTest

class TabBarControllerTests: XCTestCase {
    
    func test_viewDidLoad_setsHomeTabBarItem() {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        
        let homeBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house")!,
                                       selectedImage: nil)
        expect(barItem: sut.homeNavController.tabBarItem, toBeEqualTo: homeBarItem)
    }
    
    func test_viewDidLoad_setsFavoritesTabBarItem() {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        
        let settingsBarItem = UITabBarItem(title: "Favorites",
                                       image: UIImage(systemName: "heart")!,
                                       selectedImage: nil)
        expect(barItem: sut.favoritesNavController.tabBarItem, toBeEqualTo: settingsBarItem)
    }
    
    func test_viewDidLoad_setsEventsTabBarItem() {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        
        let settingsBarItem = UITabBarItem(title: "Events",
                                       image: UIImage(systemName: "book")!,
                                       selectedImage: nil)
        expect(barItem: sut.eventsNavController.tabBarItem, toBeEqualTo: settingsBarItem)
    }
    
    func test_viewDidLoad_setsSettingsTabBarItem() {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        
        let settingsBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gearshape")!,
                                       selectedImage: nil)
        expect(barItem: sut.settingsNavController.tabBarItem, toBeEqualTo: settingsBarItem)
    }
    
    func test_viewDidLoad_setsViewControllers() {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.viewControllers?.count, 4)
        XCTAssertEqual(sut.viewControllers?[0], sut.homeNavController)
        XCTAssertEqual(sut.viewControllers?[1], sut.favoritesNavController)
        XCTAssertEqual(sut.viewControllers?[2], sut.eventsNavController)
        XCTAssertEqual(sut.viewControllers?[3], sut.settingsNavController)
    }
    
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> TabBarController {
        let sut = TabBarController()
        trackForMemoryLeaks(sut)
        
        return sut
    }
    
    private func expect(barItem: UITabBarItem, toBeEqualTo comparedBarItem: UITabBarItem, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(barItem.title, comparedBarItem.title, file: file, line: line)
        XCTAssertEqual(barItem.image, comparedBarItem.image, file: file, line: line)
        XCTAssertEqual(barItem.selectedImage, comparedBarItem.selectedImage, file: file, line: line)
    }
}
