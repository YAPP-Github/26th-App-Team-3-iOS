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
        case kakaoLogin
        case appleLogin(nickname: String?, authToken: String)
        case logout
    }

    public struct Output {
        let loginResultPublisher: AnyPublisher<Bool, Never>
        let logoutResultPublisher: AnyPublisher<Bool, Never>
    }

    private(set) var output: Output
    private let loginResultSubject = PassthroughSubject<Bool, Never>()
    private let logoutResultSubject = PassthroughSubject<Bool, Never>()
    private let loginUseCase: LoginUseCaseProtocol
    private let logoutUseCase: LogoutUseCaseProtocol

    public init(loginUseCase: LoginUseCaseProtocol, logoutUseCase: LogoutUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.output = Output(
            loginResultPublisher: loginResultSubject.eraseToAnyPublisher(),
            logoutResultPublisher: logoutResultSubject.eraseToAnyPublisher()
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
                    BitnagilLogger.log(logType: .error, message: "\(error.localizedDescription)")
                    loginResultSubject.send(false)
                }
            }

        case .appleLogin(let nickname, let authToken):
            Task {
                do {
                    try await loginUseCase.appleLogin(nickname: nickname, authToken: authToken)
                    loginResultSubject.send(true)
                } catch {
                    BitnagilLogger.log(logType: .error, message: "\(error.localizedDescription)")
                    loginResultSubject.send(false)
                }
            }

        case .logout:
            Task {
                do {
                    try await logoutUseCase.logout()
                    logoutResultSubject.send(true)
                } catch {
                    BitnagilLogger.log(logType: .error, message: "\(error.localizedDescription)")
                    logoutResultSubject.send(false)
                }
            }
        }
    }
}
