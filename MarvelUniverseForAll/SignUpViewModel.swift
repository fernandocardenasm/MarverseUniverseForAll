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
    @Published var buttonPressed = false

    // Oupt
    @Published var buttonEnabled = false
    @Published var signUpSuccess = false
    
    public var signUpFinishedSubject = PassthroughSubject<Void, Never>()

    private let userCreator: UserCreator
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(userCreator: UserCreator) {
        self.userCreator = userCreator
        // Setup isValid
        Publishers.CombineLatest(areFieldsValidPublisher(), $buttonPressed).receive(on: RunLoop.main)
            .map { fieldsValid, pressed in
                fieldsValid && !pressed
            }
            .assign(to: \.buttonEnabled, on: self)
            .store(in: &cancellableSet)
        
        $buttonPressed.sink { [weak self] pressed in
            guard pressed else { return }
            
            self?.signup()
        }
        .store(in: &cancellableSet)
    }

    func signup() {
        userCreator.createUser(email: email.lowercased(), password: password)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.signUpSuccess = true
                    self?.signUpFinishedSubject.send(())
                case .failure(let error):
                    self?.signUpSuccess = false
                    print("SignUp - Error: \(error)")
                }
                self?.buttonPressed = false
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
