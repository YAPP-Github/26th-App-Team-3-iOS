//
//  LoginView.swift
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

public final class LoginView: BaseViewController<LoginViewModel> {

    private enum Layout {
        static let horizontalMargin: CGFloat = 20
        static let logoTopSpacing: CGFloat = 115
        static let logoSize: CGFloat = 335
        static let loginButtonHeight: CGFloat = 54
        static let loginButtonBottomSpacing: CGFloat = 20
        static let loginButtonSpacing: CGFloat = 12
    }

    private let logoView = UIView()
    private let kakaoLoginButton = SocialLoginButton(socialType: .kakao)
    private let appleLoginButton = SocialLoginButton(socialType: .apple)
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
        logoView.do {
            $0.backgroundColor = BitnagilColor.gray90
        }

        kakaoLoginButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.action(input: .fetchKakaoToken)
        }, for: .touchUpInside)

        appleLoginButton.addAction(UIAction { [weak self] _ in
            self?.appleLogin()
        }, for: .touchUpInside)
    }

    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground

        view.addSubview(logoView)
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)

        logoView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.top.equalTo(safeArea).offset(Layout.logoTopSpacing)
            make.size.equalTo(Layout.logoSize)
        }

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
    }

    override func bind() {
        viewModel.output.fetchTokenPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fetchTokenResult in
                guard let self else { return }
                if fetchTokenResult {
                    BitnagilLogger.log(logType: .debug, message: "토큰 값 가져오기 성공")
                    let agreementView = TermsAgreementView(viewModel: self.viewModel)
                    self.navigationController?.pushViewController(agreementView, animated: true)
                } else {
                    BitnagilLogger.log(logType: .error, message: "토큰 값 가져오기 실패")
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
extension LoginView: ASAuthorizationControllerDelegate {
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
        self.viewModel.action(input: .fetchAppleToken(nickname: nickname, authToken: authToken))
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        BitnagilLogger.log(logType: .error, message: "Apple 로그인 실패")
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginView: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? UIWindow()
    }
}
