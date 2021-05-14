//
//  TabBarItemFactory.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import UIKit

struct TabBarItemFactory {
    static func home() -> UITabBarItem {
        UITabBarItem(title: "Home",
                     image: UIImage(systemName: "house")!,
                     selectedImage: nil)
    }
    
    static func favorites() -> UITabBarItem {
        UITabBarItem(title: "Favorites",
                     image: UIImage(systemName: "heart")!,
                     selectedImage: nil)
    }
    
    static func events() -> UITabBarItem {
        UITabBarItem(title: "Events",
                     image: UIImage(systemName: "book")!,
                     selectedImage: nil)
    }
    
    static func settings() -> UITabBarItem {
        UITabBarItem(title: "Settings",
                     image: UIImage(systemName: "gearshape")!,
                     selectedImage: nil)
    }
}
