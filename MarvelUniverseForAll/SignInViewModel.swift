//
//  SignInViewModel.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 04.05.21.
//

import Combine

public class SignInViewModel: ObservableObject {
    
    @Published public var isSigningIn: Bool = false
    
    public var signInFinishedSubject = PassthroughSubject<Void, Never>()
    public var skipSignInSubject = PassthroughSubject<Void, Never>()
    
    private let loginAuthenticator: LoginAuthenticator
    private var cancellables = Set<AnyCancellable>()
    
    public init(loginAuthenticator: LoginAuthenticator) {
        self.loginAuthenticator = loginAuthenticator
    }
    
    public func signIn() {
        isSigningIn = true
        
        loginAuthenticator.signIn(email: "", password: "").sink { [weak self] _ in
            self?.isSigningIn = false
            self?.signInFinishedSubject.send(())
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
}
