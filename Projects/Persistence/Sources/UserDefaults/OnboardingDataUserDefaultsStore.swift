//
//  OnboardingDataUserDefaultsStore.swift
//  Persistence
//
//  Created by 반성준 on 6/21/25.
//

import Foundation
import Domain

/// UserDefaults를 통해 OnboardingData를 저장 및 관리하는 클래스입니다.
public final class OnboardingDataUserDefaultsStore: OnboardingDataStoreProtocol {
    private let userDefaults: UserDefaults
    private let onboardingKey = "onboardingData"

    /// 생성자
    /// - Parameter userDefaults: 저장에 사용할 UserDefaults 객체 (기본값: .standard)
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    /// 저장된 온보딩 데이터입니다.
    public var onboardingData: OnboardingData? {
        get {
            guard let data = userDefaults.data(forKey: onboardingKey) else {
                return nil
            }

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(OnboardingData.self, from: data)
            } catch {
                userDefaults.removeObject(forKey: onboardingKey)
                return nil
            }
        }

        set {
            if let onboardingData = newValue {
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(onboardingData)
                    userDefaults.set(data, forKey: onboardingKey)
                } catch {
                    // 인코딩 실패 시 기존 값을 덮어쓰지 않음
                }
            } else {
                userDefaults.removeObject(forKey: onboardingKey)
            }
        }
    }

    /// 저장된 온보딩 데이터를 삭제합니다.
    public func clearOnboardingData() {
        userDefaults.removeObject(forKey: onboardingKey)
    }
}
