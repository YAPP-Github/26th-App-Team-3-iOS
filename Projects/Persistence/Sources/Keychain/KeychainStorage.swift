//
//  KeychainStorage.swift
//  Persistence
//
//  Created by 반성준 on 6/21/25.
//

import Foundation
import Security

/// Keychain 저장소에 값을 저장/조회/삭제하는 인터페이스
public protocol KeychainStorageProtocol {
    func set(_ data: Data, forKey key: String) -> Bool
    func getData(forKey key: String) -> Data?
    func removeObject(forKey key: String) -> Bool
}

public final class KeychainStorage: KeychainStorageProtocol {
    private let service: String
    private let accessGroup: String?

    public init(service: String? = nil, accessGroup: String? = nil) {
        if let service = service {
            self.service = service
        } else {
            self.service = Bundle.main.bundleIdentifier ?? "DefaultService"
        }

        self.accessGroup = accessGroup
    }

    /// 데이터를 키체인에 저장합니다.
    /// - Parameters:
    ///   - data: 저장할 데이터
    ///   - key: 데이터의 키
    /// - Returns: 저장 성공 여부
    @discardableResult
    public func set(_ data: Data, forKey key: String) -> Bool {
        var query = baseQuery(for: key)

        let attributes: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        var status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        if status == errSecItemNotFound {
            for (attributeKey, attributeValue) in attributes {
                query[attributeKey] = attributeValue
            }

            status = SecItemAdd(query as CFDictionary, nil)
        }

        return status == errSecSuccess
    }

    /// 키에 해당하는 데이터를 조회합니다.
    /// - Parameter key: 조회할 키
    /// - Returns: 해당 키의 데이터
    public func getData(forKey key: String) -> Data? {
        var query = baseQuery(for: key)

        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess {
            return result as? Data
        }

        return nil
    }

    /// 키에 해당하는 데이터를 삭제합니다.
    /// - Parameter key: 삭제할 키
    /// - Returns: 삭제 성공 여부
    public func removeObject(forKey key: String) -> Bool {
        let query = baseQuery(for: key)
        let status = SecItemDelete(query as CFDictionary)

        return status == errSecSuccess || status == errSecItemNotFound
    }

    /// 문자열을 키체인에 저장합니다.
    /// - Parameters:
    ///   - value: 저장할 문자열
    ///   - key: 키
    /// - Returns: 저장 성공 여부
    @discardableResult
    public func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else {
            return false
        }

        return set(data, forKey: key)
    }

    /// 키에 해당하는 문자열을 조회합니다.
    /// - Parameter key: 조회할 키
    /// - Returns: 문자열 (없을 경우 nil)
    public func getString(forKey key: String) -> String? {
        guard let data = getData(forKey: key) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    // MARK: - Private

    private func baseQuery(for key: String) -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }

        return query
    }
}
