//
//  RoutineModels.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import Foundation

// MARK: - RoutineModel

struct RoutineModel {
    let id: String
    let timeRange: String
    let title: String
    let tasks: [RoutineTask]
}

// MARK: - RoutineTask

struct RoutineTask {
    let id: String
    let title: String
    let isCompleted: Bool
}

