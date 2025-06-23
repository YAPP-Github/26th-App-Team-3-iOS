//
//  KeychainTokenStore.swift
//  Persistence
//
//  Created by 반성준 on 6/21/25.
//

import Foundation
import Domain

/// Keychain에 토큰을 저장하고 불러오는 구현체
public final class KeychainTokenStore: TokenStoreProtocol {
    private let keychain: KeychainStorageProtocol

    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    /// KeychainStorage를 초기화합니다.
    /// - Parameter keychain: 키체인 저장소 프로토콜 구현체 (기본값: KeychainStorage)
    public init(keychain: KeychainStorageProtocol = KeychainStorage()) {
        self.keychain = keychain
    }

    /// Access Token을 가져오거나 저장합니다.
    public var accessToken: String? {
        get {
            guard let data = keychain.getData(forKey: accessTokenKey) else {
                return nil
            }

            return String(data: data, encoding: .utf8)
        }

        set {
            if let token = newValue,
               let data = token.data(using: .utf8) {
                _ = keychain.set(data, forKey: accessTokenKey)
            } else {
                _ = keychain.removeObject(forKey: accessTokenKey)
            }
        }
    }

    /// Refresh Token을 가져오거나 저장합니다.
    public var refreshToken: String? {
        get {
            guard let data = keychain.getData(forKey: refreshTokenKey) else {
                return nil
            }

            return String(data: data, encoding: .utf8)
        }

        set {
            if let token = newValue,
               let data = token.data(using: .utf8) {
                _ = keychain.set(data, forKey: refreshTokenKey)
            } else {
                _ = keychain.removeObject(forKey: refreshTokenKey)
            }
        }
    }

    /// 저장된 Access Token과 Refresh Token을 삭제합니다.
    public func clearTokens() {
        _ = keychain.removeObject(forKey: accessTokenKey)
        _ = keychain.removeObject(forKey: refreshTokenKey)
    }
}
