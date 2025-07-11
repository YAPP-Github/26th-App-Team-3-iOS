//
//  Logger.swift
//  Shared
//
//  Created by 최정인 on 6/19/25.
//

import OSLog

public enum BitnagilLogger {
    private static let logger = Logger()

    public static func log(
        logType: OSLogType,
        message: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let fileName = (file as NSString).lastPathComponent
        logger.log(level: logType, "[\(fileName):\(line)] \(function): \(message)")
    }
}
