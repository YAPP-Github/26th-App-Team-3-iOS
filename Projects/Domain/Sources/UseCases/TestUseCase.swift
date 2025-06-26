//
//  TestUseCase.swift
//  Domain
//
//  Created by 최정인 on 6/23/25.
//

import Foundation
import Combine
import Shared

public final class TestUseCase: TestUseCaseProtocol {
    public let testEntitySubject: CurrentValueSubject<TestEntity?, Never>
    private let testRepository: TestRepositoryProtocol

    public init(testRepository: TestRepositoryProtocol) {
        testEntitySubject = CurrentValueSubject<TestEntity?, Never>(nil)
        self.testRepository = testRepository
    }

    public func healthCheck() {
        Task {
            do {
                let entity = try await testRepository.healthCheck()
                testEntitySubject.send(entity)
            } catch {
                BitnagilLogger.log(logType: .error, message: error.localizedDescription)
            }
        }
    }
}
