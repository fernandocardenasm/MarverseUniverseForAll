//
//  SignUpView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 10.05.21.
//

import SwiftUI

public struct SignUpView: View {
    
    @ObservedObject public var viewModel: SignUpViewModel
    
    public init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Text("Sign Up to the Marvel App")
                   .padding(.vertical, 60)
                   .font(.marvelRegular)
                   .foregroundColor(.white)
            .multilineTextAlignment(.center)

            LoginFieldsView(email: $viewModel.email, password: $viewModel.password)
            .padding(.horizontal, 60)
            
            Button("Sign Up") {
            }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40).background(Color.marvelBlue)
                .opacity(viewModel.buttonEnabled ? 1 : 0.3)
            .foregroundColor(.white)
            .cornerRadius(40)
            .padding(.vertical, 10)
            .padding(.horizontal, 60)
            .disabled(!viewModel.buttonEnabled)

            ActivityIndicator(shouldAnimate: $viewModel.buttonPressed)

            Button("Dismiss") {
                viewModel.signUpFinishedSubject.send(())
            }

            Spacer()
        }
        .background(Color.red)
        .onReceive(viewModel.$signUpSuccess) { success in
            guard success else { return }
        }
    }
}
