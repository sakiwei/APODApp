//
//  LogFormatter.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

public protocol LogFormatter {
    func formatted(_ message: String, file: String, function: String, line: Int) -> String
}

public class DefaultLogFormatter: LogFormatter {
    public func formatted(_ message: String, file: String, function: String, line: Int) -> String {
        return  "[\(extractFileName(file)) \(function):\(line)] ▶︎ \(message)"
    }

    internal func extractFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return (components.isEmpty ? "" : components.last) ?? ""
    }

    public init() {
    }
}
