//
//  SignInUIComposer.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 04.05.21.
//

import SwiftUI

public final class UserManagementCoordinatorComposer {
    
    private init() {}
    
    public static func composedWith(authService: AuthService) -> UserManagementCoordinator {
        
        let userManagementCoordinator = UserManagementCoordinatorImpl(authService: authService,
                                                                      signInViewController: makeSignInViewController(authService: authService))
        return userManagementCoordinator
    }
    
    private static func makeSignInViewController(authService: AuthService) -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel(authService: FirebaseAuthService())
        let view = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
