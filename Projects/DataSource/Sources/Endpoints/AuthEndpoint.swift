//
//  AuthEndpoint.swift
//  DataSource
//
//  Created by 최정인 on 6/30/25.
//

import Foundation

enum AuthEndpoint {
    case login(socialLoginType: SocialLoginType, nickname: String?, token: String)
}

extension AuthEndpoint: Endpoint {
    var baseURL: String {
        return AppProperties.baseURL + "/api/v1/auth"
    }
    
    var path: String {
        switch self {
        case .login: baseURL + "/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: .post
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .login(_, _, let token):
            return ["Authorization": token]
        }
    }
    
    var queryParameters: [String : String] {
        switch self {
        case .login(let socialLoginType, let nickname, _):
            var parameters = ["socialType": socialLoginType.rawValue]
            if let nickname {
                parameters["nickname"] = nickname
            }
            return parameters
        }
    }
    
    var bodyParameters: [String : Any] {
        switch self {
        case .login:
            return [:]
        }
    }
}
