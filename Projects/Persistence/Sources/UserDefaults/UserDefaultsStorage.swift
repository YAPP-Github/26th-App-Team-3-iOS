//
//  SimpleUserDefaultsStore.swift
//  Persistence
//
//  Created by 반성준 on 6/23/25.
//

import Foundation
import DataSource

/// 간단한 Key-Value 저장을 위한 UserDefaults Store
public final class UserDefaultsStorage: UserDefaultsStorageProtocol {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func save(_ value: String?, forKey key: String) -> Bool {
           userDefaults.set(value, forKey: key)
           return (userDefaults.string(forKey: key) == value)
       }

       public func load(forKey key: String) -> String? {
           userDefaults.string(forKey: key)
       }

       @discardableResult
       public func remove(forKey key: String) -> Bool {
           userDefaults.removeObject(forKey: key)
           return userDefaults.object(forKey: key) == nil
       }
   }
