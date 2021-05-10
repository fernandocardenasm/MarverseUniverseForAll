//
//  SignUpViewModel.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 10.05.21.
//

import Combine
import Foundation

public class SignUpViewModel: ObservableObject {

    // Input
    @Published var email = ""
    @Published var password = ""

    // Output
    @Published var signingUpButtonEnabled = false
    @Published var isSigningUp = false

    public var signUpFinishedSubject = PassthroughSubject<Void, Never>()

    // Private
    private let userCreator: UserCreator
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(userCreator: UserCreator) {
        self.userCreator = userCreator
        // Setup isValid
        Publishers.CombineLatest(areFieldsValidPublisher(), $isSigningUp).receive(on: RunLoop.main)
            .map { fieldsValid, pressed in
                fieldsValid && !pressed
            }
            .assign(to: \.signingUpButtonEnabled, on: self)
            .store(in: &cancellableSet)
    }

    func signup() {
        isSigningUp = true
        
        userCreator.createUser(email: email.lowercased(), password: password)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.isSigningUp = false
                    self?.signUpFinishedSubject.send(())
                case .failure(let error):
                    self?.isSigningUp = false
                    print("SignUp - Error: \(error)")
                }
            },
            receiveValue: { _ in })
            .store(in: &cancellableSet)
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
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { emailValid, passwordValid in
                return emailValid && passwordValid
            }
            .eraseToAnyPublisher()
    }
}
