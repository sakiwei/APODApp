//
//  RequestTests.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import XCTest
@testable import Networking

final class RequestTests: XCTestCase {

    enum EndpointsMock: Requestable {

        case mockData

        var baseURL: String {
            return "https://www.domain.com"
        }
        var path: String {
            switch self {
            case .mockData:
                return "/api/mock_data"
            }
        }
        var data: [String: String] {
            switch self {
            default:
                return [:]
            }
        }

        var method: RequestMethod {
            switch self {
            default:
                return .GET
            }
        }
    }

    func testRequest_endpointUrlConstruction() {
        // given
        let endpoint = EndpointsMock.mockData

        // when
        let output = endpoint.URL

        // then
        XCTAssertEqual(output, "https://www.domain.com/api/mock_data")
    }
}
