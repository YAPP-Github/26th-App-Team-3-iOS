//
//  AuthError.swift
//  DataSource
//
//  Created by 최정인 on 6/30/25.
//

enum AuthError: Error, CustomStringConvertible {
    case failTokenSave

    public var description: String {
        switch self {
        case .failTokenSave:
            return "토큰 저장에 실패했습니다."
        }
    }
}
