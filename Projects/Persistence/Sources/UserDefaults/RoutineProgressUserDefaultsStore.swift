//
//  RoutineProgressUserDefaultsStore.swift
//  Persistence
//
//  Created by 반성준 on 6/21/25.
//

import Foundation
import Domain

/// UserDefaults를 이용해 RoutineProgress를 저장하고 관리하는 클래스입니다.
public final class RoutineProgressUserDefaultsStore: RoutineProgressStoreProtocol {
    private let userDefaults: UserDefaults
    private let progressKey = "routineProgress"

    /// 생성자
    /// - Parameter userDefaults: 저장에 사용할 UserDefaults 객체 (기본값: .standard)
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    /// 저장된 루틴 진행 상태입니다.
    public var routineProgress: RoutineProgress? {
        get {
            guard let data = userDefaults.data(forKey: progressKey) else {
                return nil
            }

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(RoutineProgress.self, from: data)
            } catch {
                userDefaults.removeObject(forKey: progressKey)
                return nil
            }
        }

        set {
            if let progress = newValue {
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(progress)
                    userDefaults.set(data, forKey: progressKey)
                } catch {
                    // 인코딩 실패 시 기존 값 유지
                }
            } else {
                userDefaults.removeObject(forKey: progressKey)
            }
        }
    }

    /// 저장된 루틴 진행 상태를 삭제합니다.
    public func clearRoutineProgress() {
        userDefaults.removeObject(forKey: progressKey)
    }
}
