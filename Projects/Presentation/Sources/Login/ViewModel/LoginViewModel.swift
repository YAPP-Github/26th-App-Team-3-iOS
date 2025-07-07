//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 최정인 on 6/30/25.
//

import Combine
import Domain
import Shared

public final class LoginViewModel: ViewModel {
    public enum Input {
        case fetchKakaoToken
        case fetchAppleToken(nickname: String?, authToken: String)
    }

    public struct Output {
        let fetchTokenPublisher: AnyPublisher<Bool, Never>
        let loginResultPublisher: AnyPublisher<Bool, Never>
    }

    private(set) var output: Output
    private let fetchTokenSubject = PassthroughSubject<Bool, Never>()
    private let loginResultSubject = PassthroughSubject<Bool, Never>()

    private let loginUseCase: LoginUseCaseProtocol
    private var userInformation: (nickname: String?, token: String)?
    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.output = Output(
            fetchTokenPublisher: fetchTokenSubject.eraseToAnyPublisher(),
            loginResultPublisher: loginResultSubject.eraseToAnyPublisher()
        )
    }

    public func action(input: Input) {
        switch input {
        case .fetchKakaoToken:
            Task {
                do {
                    let token = try await loginUseCase.kakaoLogin()
                    userInformation = (nil, token)
                    fetchTokenSubject.send(true)
                } catch {
                    fetchTokenSubject.send(false)
                }
            }

        case .fetchAppleToken(let nickname, let authToken):
            self.userInformation = (nickname, authToken)
            fetchTokenSubject.send(true)
        }
    }
}
