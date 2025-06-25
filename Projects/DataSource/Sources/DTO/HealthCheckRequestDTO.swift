//
//  HealthCheckRequestDTO.swift
//  DataSource
//
//  Created by 최정인 on 6/23/25.
//

import Foundation
import Domain

typealias HealthCheckRequestDTO = BaseResponseDTO<String>

extension HealthCheckRequestDTO {
    func toTestEntity() -> TestEntity {
        let entity = TestEntity(message: message)
        return entity
    }
}
