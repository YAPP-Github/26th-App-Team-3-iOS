//
//  KeyValueStorageProtocol.swift
//  DataSource
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol KeyValueStorageProtocol {
    func set(_ value: String, forKey key: String) -> Bool
    func getValue(forKey key: String) -> String?
    func removeValue(forKey key: String) -> Bool
}
