//
//  RoutineProgress.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public struct RoutineProgress: Codable, Equatable {
    public let routineId: String
    public let lastStepCompleted: Int

    public init(
        routineId: String,
        lastStepCompleted: Int
    ) {
        self.routineId = routineId
        self.lastStepCompleted = lastStepCompleted
    }
}
