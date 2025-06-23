//
//  OnboardingDataStoreProtocol.swift
//  Domain
//
//  Created by 반성준 on 6/21/25.
//

import Foundation

public protocol OnboardingDataStoreProtocol {
    var onboardingData: OnboardingData? { get set }

    func clearOnboardingData()
}
