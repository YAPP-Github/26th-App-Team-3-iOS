//
//  SimpleUserDefaultsStore.swift
//  Persistence
//
//  Created by 반성준 on 6/23/25.
//

import Foundation

/// 간단한 Key-Value 저장을 위한 UserDefaults Store
public final class SimpleUserDefaultsStore {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func set(_ value: Any?, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    public func get<T>(forKey key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }

    public func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
