//
//  RoutineProgress.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

/// 테스트 용도로 임시 작성된 타입입니다.
/// 실제 사용처 정의 시에는 수정 또는 제거될 수 있습니다.
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
