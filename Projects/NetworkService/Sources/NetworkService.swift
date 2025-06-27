//
//  NetworkService.swift
//  NetworkService
//
//  Created by 최정인 on 6/19/25.
//

import Foundation
import DataSource

public final class NetworkService: NetworkServiceProtocol {
    private let networkProvider: NetworkProviderProtocol
    private let decoder = JSONDecoder()

    public init(networkProvider: NetworkProviderProtocol = URLSession.shared) {
        self.networkProvider = networkProvider
    }

    public func request<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        let request = try endpoint.makeURLRequest()
        let (data, response) = try await networkProvider.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }

        guard !data.isEmpty else {
            throw NetworkError.emptyData
        }

        guard let responseDTO = try? decoder.decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }

        return responseDTO
    }
}
