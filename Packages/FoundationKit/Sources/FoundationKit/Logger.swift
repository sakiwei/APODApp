//
//  Logger.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

/**
 Logger configuartion options
*/
public struct LoggerOptions {
    /** A flag to enable logger printing */
    var isEnabled: Bool

    public init(isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
}

/**
 This is a logger as swift `print` replacement.
*/
public class Logger {

    /** default logger will disable log in release build automatically */
#if DEBUG
    public static let `default` = Logger(options: LoggerOptions(isEnabled: true),
                                         logWriter: ConsoleLogWriter(),
                                         logFormatter: DefaultLogFormatter())
#else
    public static let `default` = Logger(options: LoggerOptions(isEnabled: false),
                                         logWriter: ConsoleLogWriter(),
                                         logFormatter: DefaultLogFormatter())
#endif

    public var options: LoggerOptions
    public let logWriter: LogWriter
    public let logFormatter: LogFormatter

    public func debug(_ message: @autoclosure @escaping () -> String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        guard options.isEnabled else {return}
        logWriter.write(logFormatter.formatted(message(), file: file, function: function, line: line))
    }

    public init(options: LoggerOptions, logWriter: LogWriter, logFormatter: LogFormatter) {
        self.options = options
        self.logWriter = logWriter
        self.logFormatter = logFormatter
    }
}
