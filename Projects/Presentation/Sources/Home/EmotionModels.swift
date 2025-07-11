//
//  EmotionModels.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit

// MARK: - EmotionState

public struct EmotionState {
    public let type: EmotionType
    public let intensity: Double
    public let recordedAt: Date
    
    public init(type: EmotionType, intensity: Double, recordedAt: Date) {
        self.type = type
        self.intensity = intensity
        self.recordedAt = recordedAt
    }
}

// MARK: - EmotionType

public enum EmotionType: String, CaseIterable {
    case happy = "happy"
    case sad = "sad"
    case angry = "angry"
    case anxious = "anxious"
    case neutral = "neutral"
    
    var displayName: String {
        switch self {
        case .happy: return "행복"
        case .sad: return "슬픔"
        case .angry: return "화남"
        case .anxious: return "불안"
        case .neutral: return "평온"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .happy: return BitnagilColor.happy
        case .sad: return BitnagilColor.sad
        case .angry: return BitnagilColor.anxiety
        case .anxious: return BitnagilColor.lonely
        case .neutral: return BitnagilColor.lethargy
        }
    }
}
