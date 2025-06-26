//
//  DomainDependencyAssembler.swift
//  Domain
//
//  Created by 최정인 on 6/26/25.
//

import Foundation
import Shared

public struct DomainDependencyAssembler: DependencyAssemblerProtocol {
    private let preAssembler: DependencyAssemblerProtocol

    public init(preAssembler: DependencyAssemblerProtocol) {
        self.preAssembler = preAssembler
    }

    public func assemble() {
        preAssembler.assemble()

        DIContainer.shared.register(type: TestUseCaseProtocol.self) { container in
            guard let testRepository = container.resolve(type: TestRepositoryProtocol.self) else {
                return
            }
            return TestUseCase(testRepository: testRepository)
        }
    }
}
