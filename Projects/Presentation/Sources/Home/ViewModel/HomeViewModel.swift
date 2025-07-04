//
//  HomeViewModel.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import Combine
import Domain

public final class HomeViewModel: ViewModel {
    public enum Input { }

    public struct Output { }

    private(set) var output: Output

    public init() {
        self.output = Output()
    }

    public func action(input: Input) { }
}
