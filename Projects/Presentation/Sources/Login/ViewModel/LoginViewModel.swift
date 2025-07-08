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
        case toggleAgreement(termsType: TermsType)
        case toggleTotalAgreement
        case submitAgreement
    }

    public struct Output {
        let loginResultPublisher: AnyPublisher<Bool, Never>
        let agreementStatePublisher: AnyPublisher<TermsAgreementState, Never>
        let agreementResultPublisher: AnyPublisher<Bool, Never>
    }

    private(set) var output: Output
    private let loginResultSubject = PassthroughSubject<Bool, Never>()
    private let agreementStateSubject = CurrentValueSubject<TermsAgreementState, Never>(TermsAgreementState())
    private let agreementResultSubject = PassthroughSubject<Bool, Never>()

    private let loginUseCase: LoginUseCaseProtocol
    private var userInformation: (nickname: String?, token: String)?
    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.output = Output(
            loginResultPublisher: loginResultSubject.eraseToAnyPublisher(),
            agreementStatePublisher: agreementStateSubject.eraseToAnyPublisher(),
            agreementResultPublisher: agreementResultSubject.eraseToAnyPublisher()
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

        case .toggleAgreement(let termsType):
            var agreementState = agreementStateSubject.value
            agreementState.toggleState(termType: termsType)
            agreementStateSubject.send(agreementState)

        case .toggleTotalAgreement:
            var agreementState = agreementStateSubject.value
            agreementState.togleAllStates()
            agreementStateSubject.send(agreementState)

        case .submitAgreement:
            Task {
                do {
                    let agreements = agreementStateSubject.value.agreements
                    try await loginUseCase.sumbitAgreement(agreements: agreements)
                    agreementResultSubject.send(true)
                } catch {
                    agreementResultSubject.send(false)
                }
            }
        }
    }
}
