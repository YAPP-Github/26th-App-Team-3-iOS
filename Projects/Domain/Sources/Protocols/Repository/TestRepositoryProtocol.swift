//
//  TestRepositoryProtocol.swift
//  Domain
//
//  Created by 최정인 on 6/23/25.
//

import Foundation

public protocol TestRepositoryProtocol {
    func healthCheck() async throws -> TestEntity
}
