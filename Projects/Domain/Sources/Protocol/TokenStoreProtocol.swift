//
//  TokenStoreProtocol.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol TokenStoreProtocol {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }

    func clearTokens()
}
