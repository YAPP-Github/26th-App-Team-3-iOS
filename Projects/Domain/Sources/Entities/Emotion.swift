//
//  Emotion.swift
//  Domain
//
//  Created by 반성준 on 7/10/25.
//

import Foundation

public struct Emotion {
    public let id: String
    public let type: EmotionType
    public let intensity: Double
    public let recordedAt: Date
    
    public init(
        id: String,
        type: EmotionType,
        intensity: Double,
        recordedAt: Date
    ) {
        self.id = id
        self.type = type
        self.intensity = intensity
        self.recordedAt = recordedAt
    }
}
