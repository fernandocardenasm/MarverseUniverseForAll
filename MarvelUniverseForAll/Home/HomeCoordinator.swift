//
//  HomeCoordinator.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 14.05.21.
//

import SwiftUI

public class HomeCoordinator: StartableCoordinator {
    
    public weak var navController: UINavigationController?
    
    public init() {}
    
    public func start(navController: UINavigationController) {
        self.navController = navController
        
        navController.pushViewController(UIHostingController(rootView: HomeView(viewModel: HomeViewModel(characterLoader: RemoteCharacterLoader(url: URL(string: "https://www.google.com/")!,
                                                                                                                                                client: URLSessionHTTPClient(session: URLSession.shared)), imageLoader: RemoteImageLoader(imageClient: KingfisherImageClient())))), animated: true)
    }
}
