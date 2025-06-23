//
//  OnboardingData.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

/// 해당 타입은 Persistence 저장 기능 개발 시 테스트 목적으로만 사용되었습니다.
/// 실제 서비스 구현 시에는 삭제되거나, 더 구체적인 형태로 재정의될 수 있습니다.
public struct OnboardingData: Codable, Equatable {
    public let completed: Bool
    public let selectedGoals: [String]

    public init(
        completed: Bool,
        selectedGoals: [String]
    ) {
        self.completed = completed
        self.selectedGoals = selectedGoals
    }
}
