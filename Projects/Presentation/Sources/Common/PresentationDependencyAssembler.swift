//
//  PresentationDependencyAssembler.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import Foundation
import Domain
import Shared

public struct PresentationDependencyAssembler: DependencyAssemblerProtocol {
    private let preAssembler: DependencyAssemblerProtocol

    public init(preAssembler: DependencyAssemblerProtocol) {
        self.preAssembler = preAssembler
    }

    public func assemble() {
        preAssembler.assemble()
        
        DIContainer.shared.register(type: HomeViewModel.self) { container in
            guard let testUseCase = container.resolve(type: TestUseCaseProtocol.self) else { return }
            return HomeViewModel(testUseCase: testUseCase)
        }
    }
}
