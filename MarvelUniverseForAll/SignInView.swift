//
//  SignInView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Button("Sign In") {
            viewModel.signIn.send()
        }
        Button("Skip SignIn") {
            viewModel.skipSignIn.send()
        }
    }
}

class SignInViewModel: ObservableObject {
    
    var signIn = PassthroughSubject<Void, Never>()
    var skipSignIn = PassthroughSubject<Void, Never>()
}
