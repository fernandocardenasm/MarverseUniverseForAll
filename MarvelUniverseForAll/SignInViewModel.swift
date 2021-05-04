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
    
    private let authService: AuthService
    private var cancellables = Set<AnyCancellable>()
    
    public init(authService: AuthService) {
        self.authService = authService
    }
    
    public func signIn() {
        isSigningIn = true
        
        authService.signIn().sink { [weak self] _ in
            self?.isSigningIn = false
            self?.signInFinishedSubject.send(())
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
}
