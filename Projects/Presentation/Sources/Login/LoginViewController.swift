//
//  LoginViewController.swift
//  Presentation
//
//  Created by 최정인 on 6/30/25.
//

import UIKit
import Combine
import Shared
import SnapKit
import Then

public final class LoginViewController: BaseViewController<LoginViewModel> {

    private enum Layout {
        static let horizontalMargin: CGFloat = 20
        static let loginButtonHegiht: CGFloat = 54
        static let loginButtonBottomSpacing: CGFloat = 54
        static let loginButtonSpacing: CGFloat = 8
    }

    private var cancellables: Set<AnyCancellable>
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()

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
                self?.viewModel.action(input: .appleLogin)
            }, for: .touchUpInside)
        }
    }

    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground

        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)

        appleLoginButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.bottom.equalTo(safeArea).inset(Layout.loginButtonBottomSpacing)
            make.height.equalTo(Layout.loginButtonHegiht)
        }

        kakaoLoginButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(Layout.horizontalMargin)
            make.trailing.equalTo(safeArea).inset(Layout.horizontalMargin)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-Layout.loginButtonSpacing)
            make.height.equalTo(Layout.loginButtonHegiht)
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
    }
}
