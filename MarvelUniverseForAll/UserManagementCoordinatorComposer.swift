//
//  SignInUIComposer.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 04.05.21.
//

import SwiftUI

public final class UserManagementCoordinatorComposer {
    
    private init() {}
    
    public static func composedWith(loginAuthenticator: LoginAuthenticator,
                                    userCreator: UserCreator) -> UserManagementCoordinator {
        
        let userManagementCoordinator = UserManagementCoordinatorImpl(signInViewController: makeSignInViewController(loginAuthenticator: loginAuthenticator),
                                                                      signUpViewController: makeSignUpViewController(userCreator: userCreator))
        return userManagementCoordinator
    }
    
    private static func makeSignInViewController(loginAuthenticator: LoginAuthenticator) -> UIHostingController<SignInView> {
        let viewModel = SignInViewModel(loginAuthenticator: loginAuthenticator)
        let view = SignInView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
    
    private static func makeSignUpViewController(userCreator: UserCreator) -> UIHostingController<SignUpView> {
        let viewModel = SignUpViewModel(userCreator: userCreator)
        let view = SignUpView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
