//
//  RoutineProgressStoreProtocol.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol RoutineProgressStoreProtocol {
    var routineProgress: RoutineProgress? { get set }

    func clearRoutineProgress()
}
