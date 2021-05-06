//
//  SignInUIComposer.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Firebase
import SwiftUI

public final class UserManagementCoordinatorComposer {
    
    private init() {}
    
    public static func composedWith(loginAuthenticator: LoginAuthenticator) -> UserManagementCoordinator {
        
        let userManagementCoordinator = UserManagementCoordinatorImpl(signInViewController: makeSignInViewController(loginAuthenticator: loginAuthenticator))
        return userManagementCoordinator
    }
    
    private static func makeSignInViewController(loginAuthenticator: LoginAuthenticator) -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel(loginAuthenticator: loginAuthenticator)
        let view = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
