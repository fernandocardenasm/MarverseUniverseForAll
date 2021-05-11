//
//  SignInViewModel.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine
import Foundation

public class SignInViewModel: ObservableObject {
        
    // Input
    @Published var email = ""
    @Published var password = ""
    
    // Output
    @Published var singinButtonEnabled = false
    @Published public var isSigningIn: Bool = false
    
    public var signInFinishedSubject = PassthroughSubject<Void, Never>()
    public var startSignUpSubject = PassthroughSubject<Void, Never>()
    public var skipSignInSubject = PassthroughSubject<Void, Never>()
    
    // Private
    private let loginAuthenticator: LoginAuthenticator
    private var cancellables = Set<AnyCancellable>()
    
    public init(loginAuthenticator: LoginAuthenticator) {
        self.loginAuthenticator = loginAuthenticator
        
        observeChanges()
    }
    
    public func signIn() {
        isSigningIn = true
        
        loginAuthenticator.signIn(email: email, password: password).sink { [weak self] _ in
            self?.isSigningIn = false
            self?.signInFinishedSubject.send(())
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    public func skipSignIn() {
        skipSignInSubject.send(())
    }
    
    public func startSignUp() {
        startSignUpSubject.send(())
    }
    
    private func observeChanges() {
        Publishers.CombineLatest(areFieldsValidPublisher(), $isSigningIn).receive(on: RunLoop.main)
            .map { fieldsValid, signingIn in
                fieldsValid && !signingIn
            }
            .assign(to: \.singinButtonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    private func isEmailValidPublisher() -> AnyPublisher<Bool, Never> {
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                input.count > 5
            }
            .eraseToAnyPublisher()
    }

    private func isPasswordValidPublisher() -> AnyPublisher<Bool, Never> {
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                input.count > 5
            }.eraseToAnyPublisher()
    }

    private func areFieldsValidPublisher() -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailValidPublisher(),
                                 isPasswordValidPublisher())
            .debounce(for: 0.2,
                      scheduler: RunLoop.main)
            .map { emailValid, passwordValid in
                return emailValid && passwordValid
            }
            .eraseToAnyPublisher()
    }
}
