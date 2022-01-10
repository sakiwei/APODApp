//
//  NetworkErrorTests.swift
//  
//
//  Created by Sakiwei on 8/1/2022.
//

import XCTest
import Networking

class NetworkErrorTexts: XCTestCase {

    func testNetworkError_whenCompareTheSameError_areEqual() {
        let malformedURLErrorA = NetworkError.malformedURL
        let malformedURLErrorB = NetworkError.malformedURL

        let notConnectedErrorA = NetworkError.notConnectedToInternet
        let notConnectedErrorB = NetworkError.notConnectedToInternet

        let invalidResponseErrorA = NetworkError.invalidResponse
        let invalidResponseErrorB = NetworkError.invalidResponse

        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://www.domain.com")!,
                                              statusCode: 200,
                                              httpVersion: "1",
                                              headerFields: nil)!

        let unacceptedCodeErrorA = NetworkError.unacceptedCode(status: 200,
                                                               response: httpURLResponse,
                                                               data: "".data(using: .utf8)!)
        let unacceptedCodeErrorB = NetworkError.unacceptedCode(status: 200,
                                                               response: httpURLResponse,
                                                               data: "".data(using: .utf8)!)

        XCTAssertEqual(malformedURLErrorA, malformedURLErrorB)
        XCTAssertEqual(notConnectedErrorA, notConnectedErrorB)
        XCTAssertEqual(invalidResponseErrorA, invalidResponseErrorB)
        XCTAssertEqual(unacceptedCodeErrorA, unacceptedCodeErrorB)
    }

    func testNetworkError_whenCompareTheDifferentError_areNotEqual() throws {
        let malformedURLError = NetworkError.malformedURL

        let notConnectedError = NetworkError.notConnectedToInternet

        let invalidResponseError = NetworkError.invalidResponse

        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://www.domain.com")!,
                                              statusCode: 200,
                                              httpVersion: "1",
                                              headerFields: nil)!

        let unacceptedCodeError = NetworkError.unacceptedCode(status: 200,
                                                              response: httpURLResponse,
                                                              data: "".data(using: .utf8)!)

        try XCTAssertNotEqualArray(malformedURLError, [notConnectedError, invalidResponseError, unacceptedCodeError])

        try XCTAssertNotEqualArray(notConnectedError, [malformedURLError, invalidResponseError, unacceptedCodeError])

        try XCTAssertNotEqualArray(invalidResponseError, [malformedURLError, notConnectedError, unacceptedCodeError])

        try XCTAssertNotEqualArray(unacceptedCodeError, [malformedURLError, notConnectedError, invalidResponseError])
    }
}

private extension XCTestCase {
    func XCTAssertNotEqualArray<T>(_ expression1: @autoclosure () throws -> T,
                                   _ expression2: @autoclosure () throws -> [T],
                                   _ message: @autoclosure () -> String = "",
                                   file: StaticString = #filePath,
                                   line: UInt = #line) throws where T: Equatable {
        let list = try expression2()
        let compareTarget = try expression1()
        for item in list {
            XCTAssertNotEqual(compareTarget, item)
        }
    }
}
