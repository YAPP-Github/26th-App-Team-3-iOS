//
//  TestUseCaseProtocol.swift
//  Domain
//
//  Created by 최정인 on 6/26/25.
//

import Foundation
import Combine

public protocol TestUseCaseProtocol {
    var testEntitySubject: CurrentValueSubject<TestEntity?, Never> { get }

    // TODO: 기능 구현 후 삭제할 예정입니다.
    /// 개발 서버의 health-check API를 수행합니다.
    func healthCheck()
}
