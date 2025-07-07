//
//  LoginUseCaseProtocol.swift
//  Domain
//
//  Created by 최정인 on 6/30/25.
//

public protocol LoginUseCaseProtocol {
    /// 카카오 소셜 로그인을 진행합니다.
    /// - Returns: 카카오 SDK를 통해 받은 토큰 값을 반환합니다.
    func kakaoLogin() async throws -> String

    /// Apple 소셜 로그인을 진행합니다.
    /// - Parameters:
    ///   - nickname: Apple 계정의 이름입니다. 첫 로그인 시에만 전달되며 이후에는 UserDefaults에 저장된 값을 사용합니다.
    ///   - authToken: Apple로부터 발급받은 authorization token 값입니다.
    func appleLogin(nickname: String?, authToken: String) async throws
}
