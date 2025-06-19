//
//  DIContainer.swift
//  Shared
//
//  Created by 최정인 on 6/19/25.
//

import Foundation

public final class DIContainer {
    public static let shared = DIContainer()
    private var storage: [String: Any] = [:]

    private init() { }

    public func register<T>(type: T.Type, instance: T) {
        storage["\(type)"] = instance
    }

    public func resolve<T>(type: T.Type) -> T? {
        guard let instance = storage["\(type)"] as? T else {
            // TODO: Logger 찍기
            return nil
        }
        return instance
    }
}
