//
//  OnboardingData.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

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
