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
        
        DIContainer.shared.register(type: HomeViewModel.self) { _ in
            return HomeViewModel()
        }

        DIContainer.shared.register(type: LoginViewModel.self) { container in
            guard let loginUseCase = container.resolve(type: LoginUseCaseProtocol.self)
            else { return }
            return LoginViewModel(loginUseCase: loginUseCase)
        }
    }
}
