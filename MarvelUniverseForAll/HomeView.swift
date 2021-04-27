//
//  HomeView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Text("Welcome to the Marvel Universe. Here you find all the available content")
    }
}
