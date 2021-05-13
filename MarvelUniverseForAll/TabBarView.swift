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
            
            FavoritesView().tabItem {
                Label("Favorites", systemImage: "heart")
            }
            
            EventsView().tabItem {
                Label("Events", systemImage: "book")
            }
            
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

struct SettingsView: View {
    
    var body: some View {
        Text("Settings")
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("Favorites")
    }
}

struct EventsView: View {
    var body: some View {
        Text("Events")
    }
}
