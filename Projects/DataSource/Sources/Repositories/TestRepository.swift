//
//  TestRepository.swift
//  DataSource
//
//  Created by 최정인 on 6/21/25.
//

import Foundation
import Domain

public final class TestRepository: TestRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    public func healthCheck() async throws -> TestEntity {
        let response = try await networkService.request(
            endpoint: TestEndpoint.healthCheck,
            type: HealthCheckRequestDTO.self)

        return response.toTestEntity()
    }
}
