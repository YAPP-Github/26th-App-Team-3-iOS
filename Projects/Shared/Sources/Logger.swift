//
//  Logger.swift
//  Shared
//
//  Created by 최정인 on 6/19/25.
//

import OSLog

public enum BitnagilLogger {
    private static let logger = Logger()

    public static func log(logType: OSLogType, message: String) {
        logger.log(level: logType, "\(message)")
    }
}
