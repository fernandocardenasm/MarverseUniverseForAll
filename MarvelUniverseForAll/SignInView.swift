//
//  SignInView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

public struct SignInView: View {
    
    @ObservedObject public var viewModel: SignInViewModel
    
    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text("Welcome to the Marvel World")
                .padding(.vertical, 60)
                .font(.marvelRegular)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            LoginFieldsView(email: $viewModel.email,
                            password: $viewModel.password)
                .padding(.horizontal, 60)

            Button("Sign In") {
                viewModel.signIn()
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40)
            .background(Color.marvelBlue)
            .opacity(viewModel.singinButtonEnabled ? 1 : 0.3)
            .foregroundColor(.white)
            .cornerRadius(40)
            .padding(.vertical, 10)
            .padding(.horizontal, 60)
            .disabled(!viewModel.singinButtonEnabled)

            ActivityIndicator(shouldAnimate: $viewModel.isSigningIn)

            Text("Do not have an account?")
                .foregroundColor(.white)
                .padding()
            Button("Sign up here") {
                viewModel.startSignUp()
            }
            .padding(.vertical, 30)
            Button("Skip Sign In") {
                viewModel.skipSignIn()
            }
            Spacer()
        }
        .background(Color.marvelRed)
        .onAppear{ print("Appeared") }
    }
}

extension Font {
    static var marvelRegular: Font {
        Font.custom("Marvel-Regular", size: 30)
    }
}


extension Color {
    static var marvelRed: Color {
        Color(UIColor(red: 226/255.0, green: 54/255.0, blue: 54/255.0, alpha: 1.0))
    }

    static var marvelBlue: Color {
        Color(UIColor(red: 81/255.0, green: 140/255.0, blue: 202/255.0, alpha: 1.0))
    }
}

struct LoginFieldsView: View {
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                TextField("Enter your email...", text: $email)
                    .foregroundColor(.white)
            }.padding(.vertical, 10)

            HStack {
                Image(systemName: "lock.circle")
                TextField("Enter your password...", text: $password)
                    .foregroundColor(.white)
            }
                .padding(.vertical, 10)
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        shouldAnimate ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
