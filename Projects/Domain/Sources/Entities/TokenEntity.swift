//
//  TokenEntity.swift
//  Domain
//
//  Created by 최정인 on 6/30/25.
//

public struct TokenEntity {
    public let accessToken: String
    public let refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
