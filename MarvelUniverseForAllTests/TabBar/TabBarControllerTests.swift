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
        let sut = TabBarController()
        sut.loadViewIfNeeded()
        
        let homeBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house")!,
                                       selectedImage: nil)
        expect(barItem: sut.homeNavController.tabBarItem, toBeEqualTo: homeBarItem)
    }
    
    func expect(barItem: UITabBarItem, toBeEqualTo comparedBarItem: UITabBarItem) {
        XCTAssertEqual(barItem.title, comparedBarItem.title)
        XCTAssertEqual(barItem.image, comparedBarItem.image)
        XCTAssertEqual(barItem.selectedImage, comparedBarItem.selectedImage)
    }
}
