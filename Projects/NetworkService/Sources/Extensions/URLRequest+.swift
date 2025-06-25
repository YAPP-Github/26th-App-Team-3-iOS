//
//  URLRequest+.swift
//  NetworkService
//
//  Created by 최정인 on 6/21/25.
//

import Foundation
import DataSource

extension URLRequest {
    init(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        self.init(url: url)
    }

    mutating func makeHeaders(headers: [String: String]) {
        for header in headers {
            addValue(header.value, forHTTPHeaderField: header.value)
        }
    }

    mutating func makeParameters(
        with parameters: [String: Any],
        method: HTTPMethod,
        path: String
    ) throws {
        switch method {
        case .get:
            guard var components = URLComponents(string: path) else {
                throw NetworkError.invalidURL
            }

            components.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value as? String)
            }

            try self = URLRequest(urlString: components.url?.absoluteString ?? "")
        default:
            httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
    }
}
