//
//  LogUtils.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import FoundationKit

func log(_ message: @autoclosure @escaping () -> String,
         file: String = #file,
         function: String = #function,
         line: Int = #line) {
    Logger.default.debug(message(), file: file, function: function, line: line)
}
