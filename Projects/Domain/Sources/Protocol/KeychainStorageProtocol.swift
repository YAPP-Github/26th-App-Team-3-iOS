//
//  KeychainStorageProtocol.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol KeychainStorageProtocol {
    func set(_ value: Data, forKey key: String) -> Bool
    func get(forKey key: String) -> Data?
    func removeObject(forKey key: String) -> Bool
}
