//
//  AuthRepositoryProtocol.swift
//  Domain
//
//  Created by 최정인 on 6/30/25.
//

public protocol AuthRepositoryProtocol {
    /// 카카오 소셜 로그인을 진행합니다.
    func kakaoLogin() async throws
}
