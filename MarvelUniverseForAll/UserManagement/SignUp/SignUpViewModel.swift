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
    @Published public var email = ""
    @Published public var password = ""

    // Output
    @Published public var signingUpButtonEnabled = false
    @Published public var isSigningUp = false
    @Published public var errorMessage = ""

    public var signUpFinishedSubject = PassthroughSubject<Void, Never>()

    // Private
    private let userCreator: UserCreator
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(userCreator: UserCreator) {
        self.userCreator = userCreator
        
        observeChanges()
    }

    public func signup() {
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
                    self?.errorMessage = "Sign up failed, Error: \(error)"
                }
            },
            receiveValue: { _ in })
            .store(in: &cancellableSet)
    }
    
    public func skipSignUp() {
        signUpFinishedSubject.send(())
    }
    
    private func observeChanges() {
        Publishers.CombineLatest(areFieldsValidPublisher(), $isSigningUp).receive(on: RunLoop.main)
            .map { fieldsValid, pressed in
                fieldsValid && !pressed
            }
            .assign(to: \.signingUpButtonEnabled, on: self)
            .store(in: &cancellableSet)
    }
    
    private func isEmailValidPublisher() -> AnyPublisher<Bool, Never> {
        $email.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                UserEmailPolicy.evaluate(with: input)
            }
            .eraseToAnyPublisher()
    }
    
    private func isPasswordValidPublisher() -> AnyPublisher<Bool, Never> {
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                UserPasswordPolicy.evaluate(with: input)
            }.eraseToAnyPublisher()
    }
    
    private func areFieldsValidPublisher() -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailValidPublisher(),
                                 isPasswordValidPublisher())
            .map { emailValid, passwordValid in
                return emailValid && passwordValid
            }
            .eraseToAnyPublisher()
    }
}

private struct UserEmailPolicy {
    private static let regex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
        "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

    public static func evaluate(with input: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: input)
    }
}

private struct UserPasswordPolicy {
    public static func evaluate(with input: String) -> Bool {
        return input.count > 5
    }
}
