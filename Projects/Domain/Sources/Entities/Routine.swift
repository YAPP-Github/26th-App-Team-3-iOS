//
//  Routine.swift
//  Domain
//
//  Created by 반성준 on 7/10/25.
//

import Foundation

public struct Routine {
    public let id: String
    public let title: String
    public let timeRange: String
    public let tasks: [RoutineTask]
    
    public init(
        id: String,
        title: String,
        timeRange: String,
        tasks: [RoutineTask]
    ) {
        self.id = id
        self.title = title
        self.timeRange = timeRange
        self.tasks = tasks
    }
}
