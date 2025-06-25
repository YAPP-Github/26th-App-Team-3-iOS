//
//  TestUseCase.swift
//  Domain
//
//  Created by 최정인 on 6/23/25.
//

import Foundation
import Shared

public final class TestUseCase {
    private let testRepository: TestRepositoryProtocol

    public init(testRepository: TestRepositoryProtocol) {
        self.testRepository = testRepository
    }

    public func healthCheck() async -> TestEntity? {
        do {
            let entity = try await testRepository.healthCheck()
            return entity
        } catch {
            BitnagilLogger.log(logType: .error, message: error.localizedDescription)
        }
        return nil
    }
}
