//
//  TabBarView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 29.04.21.
//

import SwiftUI

public struct TabBarView: View {
    
    public init() {}
    
    public var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Menu", systemImage: "house")
            }
        }
    }
}
