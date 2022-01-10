//
//  QueryUtilsTests.swift
//  
//
//  Created by Sakiwei on 8/1/2022.
//

import XCTest
@testable import Networking

class QueryUtilsTests: XCTestCase {

    func testQueryUtils_writeCorrectQueryString_normalCharacters() {
        // given
        let queries: [String: String] = ["name": "Steve Jobs", "age": "56"]
        // when
        let queryString = queries.queryString()
        // then
        XCTAssertEqual(queryString, "age=56&name=Steve%20Jobs")
    }

    func testQueryUtils_writeCorrectQueryString_specialCharaters() {
        // given
        let queries: [String: String] = ["name": "偉+Wai", "questionMark": "?"]
        // when
        let queryString = queries.queryString()
        // then
        XCTAssertEqual(queryString, "name=%E5%81%89+Wai&questionMark=%3F")
    }

    func testQueryUtils_appendURLWithQueries() {
        // given
        let url = URL(string: "https://example.com")!
        let queries = ["name": "Steve Jobs", "age": "56"]
        // when
        let queryString = url.withQueries(queries)
        // then
        XCTAssertEqual(queryString.absoluteString, "https://example.com?age=56&name=Steve%20Jobs")
    }

    func testQueryUtils_appendURLWithQueries_withEmptyQueries() {
        // given
        let url = URL(string: "https://example.com")!
        let queries: [String: String] = [:]
        // when
        let queryString = url.withQueries(queries)
        // then
        XCTAssertEqual(queryString.absoluteString, "https://example.com")
    }

    func testQueryUtils_queryStringMethodAndWithQueriesMethod_withTheSameResult() {
        // given
        let url = URL(string: "https://example.com")!
        let queries = ["name": "Steve Jobs", "age": "56"]
        // when
        let outputURL = url.withQueries(queries)
        let outputQueryString = queries.queryString()
        // then
        XCTAssertEqual(outputURL.query, outputQueryString)
    }
}
