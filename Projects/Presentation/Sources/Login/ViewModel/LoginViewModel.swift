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
        case withdraw
        case reissue
    }

    public struct Output {
        let loginResultPublisher: AnyPublisher<Bool, Never>
        let logoutResultPublisher: AnyPublisher<Bool, Never>
        let withdrawResultPublisher: AnyPublisher<Bool, Never>
        let reissueResultPublisher: AnyPublisher<Bool, Never>
    }

    private(set) var output: Output
    private let loginResultSubject = PassthroughSubject<Bool, Never>()
    // TODO: 추후 설정 페이지로 옮겨야 합니다.
    private let logoutResultSubject = PassthroughSubject<Bool, Never>()
    private let withdrawResultSubject = PassthroughSubject<Bool, Never>()
    private let reissueResultSubject = PassthroughSubject<Bool, Never>()

    private let loginUseCase: LoginUseCaseProtocol
    // TODO: 추후 설정 페이지로 옮겨야 합니다.
    private let logoutUseCase: LogoutUseCaseProtocol
    private let withdrawUseCase: WithdrawUseCaseProtocol

    public init(
        loginUseCase: LoginUseCaseProtocol,
        logoutUseCase: LogoutUseCaseProtocol,
        withdrawUseCase: WithdrawUseCaseProtocol
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.withdrawUseCase = withdrawUseCase
        self.output = Output(
            loginResultPublisher: loginResultSubject.eraseToAnyPublisher(),
            logoutResultPublisher: logoutResultSubject.eraseToAnyPublisher(),
            withdrawResultPublisher: withdrawResultSubject.eraseToAnyPublisher(),
            reissueResultPublisher: reissueResultSubject.eraseToAnyPublisher()
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

        case .withdraw:
            Task {
                do {
                    try await withdrawUseCase.withdraw()
                    withdrawResultSubject.send(true)
                } catch {
                    BitnagilLogger.log(logType: .error, message: "\(error.localizedDescription)")
                    withdrawResultSubject.send(false)
                }
            }

        case .reissue:
            Task {
                do {
                    try await logoutUseCase.reissueToken()
                    reissueResultSubject.send(true)
                } catch {
                    BitnagilLogger.log(logType: .error, message: "\(error.localizedDescription)")
                    reissueResultSubject.send(false)
                }
            }
        }
    }
}
