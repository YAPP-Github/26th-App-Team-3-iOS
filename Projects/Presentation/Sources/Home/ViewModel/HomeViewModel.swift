//
//  HomeViewModel.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import Combine
import Domain

public final class HomeViewModel: ViewModel {
    public enum Input {
        case healthCheck
    }

    public struct Output {
        let testEntityPublisher: AnyPublisher<TestEntity?, Never>
    }

    private(set) var output: Output
    private let testUseCase: TestUseCaseProtocol

    public init(testUseCase: TestUseCaseProtocol) {
        self.testUseCase = testUseCase
        self.output = Output(
            testEntityPublisher: testUseCase.testEntitySubject.eraseToAnyPublisher()
        )
    }

    public func action(input: Input) {
        switch input {
        case .healthCheck: healthCheck()
        }
    }

    private func healthCheck() {
        testUseCase.healthCheck()
    }
}
