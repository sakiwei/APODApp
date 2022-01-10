//
//  File.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation
import os

public protocol LogWriter {
    func write(_ message: String)
}

public class ConsoleLogWriter: LogWriter {
    public func write(_ message: String) {
        os_log("%@", log: OSLog.default, type: OSLogType.debug, message)
    }
}
