//
//  RoutineUseCaseProtocol.swift
//  Domain
//
//  Created by 반성준 on 7/3/25.
//

import Foundation

public protocol RoutineUseCaseProtocol {
    func getRoutines(for date: Date) async throws -> [Routine]
    func createRoutine(_ routine: Routine) async throws
    func updateRoutine(_ routine: Routine) async throws
    func deleteRoutine(id: String) async throws
}
