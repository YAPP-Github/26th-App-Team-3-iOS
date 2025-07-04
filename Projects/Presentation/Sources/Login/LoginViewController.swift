//
//  LoginViewController.swift
//  Presentation
//
//  Created by 최정인 on 6/30/25.
//

import UIKit
import AuthenticationServices
import Combine
import Shared
import SnapKit
import Then

public final class LoginViewController: BaseViewController<LoginViewModel> {

    private enum Layout {
        static let horizontalMargin: CGFloat = 20
        static let loginButtonHeight: CGFloat = 54
        static let loginButtonBottomSpacing: CGFloat = 54
        static let loginButtonSpacing: CGFloat = 8
    }

    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    private let logoutButton = UIButton()
    private var cancellables: Set<AnyCancellable>

    public override init(viewModel: LoginViewModel) {
        cancellables = []
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureAttribute() {
        kakaoLoginButton.do {
            $0.setTitle("카카오로 시작하기", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.addAction(UIAction { [weak self] _ in
                self?.viewModel.action(input: .kakaoLogin)
            }, for: .touchUpInside)
        }

        appleLoginButton.do {
            $0.setTitle("Apple로 시작하기", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.addAction(UIAction { [weak self] _ in
                self?.appleLogin()
            }, for: .touchUpInside)
        }

        logoutButton.do {
            $0.setTitle("로그아웃", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.addAction(UIAction { [weak self] _ in
                self?.viewModel.action(input: .logout)
            }, for: .touchUpInside)
        }
    }

    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground

        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)
        view.addSubview(logoutButton)

        kakaoLoginButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-Layout.loginButtonSpacing)
            make.height.equalTo(Layout.loginButtonHeight)
        }

        appleLoginButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.bottom.equalTo(safeArea).inset(Layout.loginButtonBottomSpacing)
            make.height.equalTo(Layout.loginButtonHeight)
        }

        logoutButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-Layout.loginButtonSpacing)
            make.height.equalTo(Layout.loginButtonHeight)
        }
    }

    override func bind() {
        viewModel.output.loginResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { isSuccess in
                if isSuccess {
                    // TODO: 로그인 성공 시 화면을 이동해야 합니다.
                    BitnagilLogger.log(logType: .debug, message: "로그인 성공")
                } else {
                    // TODO: 로그인 실패 시, 에러 처리를 해야 합니다.
                    BitnagilLogger.log(logType: .error, message: "로그인 실패")
                }
            }
            .store(in: &cancellables)

        viewModel.output.logoutResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { logoutResult in
                if logoutResult {
                    BitnagilLogger.log(logType: .debug, message: "로그아웃 성공")
                } else {
                    BitnagilLogger.log(logType: .debug, message: "로그아웃 실패")
                }
            }
            .store(in: &cancellables)
    }

    private func appleLogin() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard
            let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let authCodeData = credential.authorizationCode,
            let authToken = String(data: authCodeData, encoding: .utf8)
        else {
            BitnagilLogger.log(logType: .error, message: "Apple AuthorizationCode 파싱 실패")
            return
        }

        let givenName = credential.fullName?.givenName
        let familyName = credential.fullName?.familyName

        var nickname: String? = nil
        if let givenName, let familyName {
            nickname = "\(familyName)\(givenName)"
        }
        self.viewModel.action(input: .appleLogin(nickname: nickname, authToken: authToken))
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        BitnagilLogger.log(logType: .error, message: "Apple 로그인 실패")
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? UIWindow()
    }
}
