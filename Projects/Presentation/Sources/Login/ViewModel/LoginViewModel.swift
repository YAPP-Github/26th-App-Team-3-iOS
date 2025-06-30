//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 최정인 on 6/30/25.
//

import Combine
import Domain

public final class LoginViewModel: ViewModel {
    public enum Input {
        case kakaoLogin
    }

    public struct Output {
        let loginResultPublisher: AnyPublisher<Bool, Never>
    }

    private(set) var output: Output
    private let loginResultSubject = PassthroughSubject<Bool, Never>()
    private let loginUseCase: LoginUseCaseProtocol

    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.output = Output(
            loginResultPublisher: loginResultSubject.eraseToAnyPublisher()
        )
    }

    public func action(input: Input) {
        switch input {
        case .kakaoLogin:
            Task {
                do {
                    try await loginUseCase.kakaoLogin()
                    loginResultSubject.send(true)
                } catch {
                    loginResultSubject.send(false)
                }
            }
        }
    }

}
