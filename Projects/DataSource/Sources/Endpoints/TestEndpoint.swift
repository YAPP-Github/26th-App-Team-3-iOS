//
//  TestEndpoint.swift
//  DataSource
//
//  Created by 최정인 on 6/21/25.
//

import Foundation

enum TestEndpoint {
    case healthCheck
}

extension TestEndpoint: Endpoint {
    var baseURL: String {
        return AppProperties.baseURL + "/api/v1/health-check"
    }
    
    var path: String {
        switch self {
        case .healthCheck:
            return baseURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .healthCheck: .get
        }
    }
    
    var headers: [String : String] {
        return ["accept": "*/*"]
    }

    var parameters: [String : Any] { return [:] }
}
