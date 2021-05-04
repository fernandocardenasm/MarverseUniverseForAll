//
//  SignInView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

public struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    public var body: some View {
        Button("Sign In") {
            viewModel.signIn()
        }
        Button("Skip SignIn") {
            viewModel.skipSignInSubject.send(())
        }
    }
}
