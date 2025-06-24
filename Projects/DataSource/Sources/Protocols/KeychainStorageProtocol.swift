//
//  KeyValueStorageProtocol.swift
//  DataSource
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol KeyValueStorageProtocol {
    func save(_ value: String, forKey key: String) -> Bool
    func load(forKey key: String) -> String?
    func remove(forKey key: String) -> Bool
}
