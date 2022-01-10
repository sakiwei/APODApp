//
//  LoggerTests.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import XCTest
import FoundationKit

final class LoggerTests: XCTestCase {

    class LogWriterMock: LogWriter {
        private var didWriteCallback: (String) -> Void
        init(didWriteCallback: @escaping (String) -> Void) {
            self.didWriteCallback = didWriteCallback
        }
        func write(_ message: String) {
            self.didWriteCallback(message)
        }
    }

    class LogFormatterMock: LogFormatter {
        func formatted(_ message: String, file: String, function: String, line: Int) -> String {
            return message
        }
    }

    var formatterMock: LogFormatterMock?
    override func setUpWithError() throws {
        self.formatterMock = LogFormatterMock()
    }

    func testLogger_whenLoggerEnabled_thenLogWriterWriteLog() {
        // given
        let sendMessage = "TestMessage"
        let options = LoggerOptions(isEnabled: true)
        var updatedValue = ""
        let mockLogWriter = LogWriterMock { message in
            updatedValue = message
        }
        let logger = Logger(options: options, logWriter: mockLogWriter, logFormatter: self.formatterMock!)

        // when
        logger.debug(sendMessage)

        // then
        XCTAssertEqual(updatedValue, sendMessage)
    }

    func testLogger_whenLoggerDisabled_thenLogWriterDontWriteLog() {
        // given
        let sendMessage = "TestMessage"
        let options = LoggerOptions(isEnabled: false)
        var updatedValue = ""
        let mockLogWriter = LogWriterMock { message in
            updatedValue = message
        }
        let logger = Logger(options: options, logWriter: mockLogWriter, logFormatter: self.formatterMock!)

        // when
        logger.debug(sendMessage)

        // then
        XCTAssertEqual(updatedValue, "")
    }
}
