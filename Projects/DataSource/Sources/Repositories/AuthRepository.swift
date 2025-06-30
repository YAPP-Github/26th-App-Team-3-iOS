//
//  AuthRepository.swift
//  DataSource
//
//  Created by 최정인 on 6/30/25.
//

import Foundation
import Domain
import Shared
import KakaoSDKUser
import KakaoSDKAuth

public final class AuthRepository: AuthRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let keychainStorage: KeychainStorageProtocol

    public init(networkService: NetworkServiceProtocol, keychainStorage: KeychainStorageProtocol) {
        self.networkService = networkService
        self.keychainStorage = keychainStorage
    }

    public func kakaoLogin() async throws {
        let accessToken = try await fetchKakaoToken()
        try await requestServerLogin(socialType: .kakao, nickname: nil, token: accessToken)
    }

    private func fetchKakaoToken() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            let resultHandler: (OAuthToken?, Error?) -> Void = { oauthToken, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let oauthToken {
                    continuation.resume(returning: oauthToken.accessToken)
                }
            }

            Task { @MainActor in
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk(completion: resultHandler)
                } else {
                    UserApi.shared.loginWithKakaoAccount(completion: resultHandler)
                }
            }
        }
    }

    private func requestServerLogin(
        socialType: SocialLoginType,
        nickname: String?,
        token: String
    ) async throws {
        let endpoint = AuthEndpoint.login(
            socialLoginType: socialType,
            nickname: nickname,
            token: token)

        let tokenResponse = try await networkService.request(endpoint: endpoint, type: TokenResponseDTO.self)
        let tokenEntity = tokenResponse.data.toTokenEntity()
        guard saveToken(tokenType: .accessToken, token: tokenEntity.accessToken),
              saveToken(tokenType: .refreshToken, token: tokenEntity.refreshToken)
        else {
            throw AuthError.failTokenSave
        }
        BitnagilLogger.log(logType: .debug, message: "AccessToken Saved: \(tokenEntity.accessToken)")
        BitnagilLogger.log(logType: .debug, message: "RefreshToken Saved: \(tokenEntity.refreshToken)")
    }

    private func saveToken(tokenType: TokenType, token: String) -> Bool {
        return keychainStorage.save(token, forKey: tokenType.rawValue)
    }
}
