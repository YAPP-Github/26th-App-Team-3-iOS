//
//  TokenResponseDTO.swift
//  DataSource
//
//  Created by 최정인 on 6/30/25.
//

import Domain

typealias TokenResponseDTO = BaseResponseDTO<TokenResponse>

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

extension TokenResponse {
    func toTokenEntity() -> TokenEntity {
        return TokenEntity(accessToken: accessToken, refreshToken: refreshToken)
    }
}
