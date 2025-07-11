//
//  EmotionUseCaseProtocol.swift
//  Domain
//
//  Created by 반성준 on 7/3/25.
//

import Foundation

public protocol EmotionUseCaseProtocol {
    func getTodayEmotion() async throws -> Emotion?
    func recordEmotion(_ emotion: Emotion) async throws
    func getEmotions(from startDate: Date, to endDate: Date) async throws -> [Emotion]
}
