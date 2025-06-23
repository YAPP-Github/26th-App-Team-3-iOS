//
//  RoutineProgressStoreProtocol.swift
//  DataSource
//
//  Created by 반성준 on 6/21/25.
//

import Foundation
import Domain

public protocol RoutineProgressStoreProtocol {
    var routineProgress: RoutineProgress? { get set }

    func clearRoutineProgress()
}
