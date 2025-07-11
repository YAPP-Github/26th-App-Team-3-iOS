//
//  RoutineTask.swift
//  Domain
//
//  Created by 반성준 on 7/10/25.
//

import Foundation

public struct RoutineTask {
    public let id: String
    public let title: String
    public let isCompleted: Bool
    
    public init(
        id: String,
        title: String,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
