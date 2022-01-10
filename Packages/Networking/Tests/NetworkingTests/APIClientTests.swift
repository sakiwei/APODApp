//
//  APIClientTests.swift
//  
//
//  Created by Sakiwei on 8/1/2022.
//

import XCTest
@testable import Networking

private struct TestModel: Codable, Equatable {
    public let date: String
    public let title: String

    public enum CodingKeys: String, CodingKey {
        case date
        case title
    }

    public init(
        date: String,
        title: String
    ) {
        self.date = date
        self.title = title
    }
}

class APIClientTests: XCTestCase {

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

    class SessionManagerMock: SessionManager {
        var returnData: Data!
        var returnError: Error?
        var onExecute: ((Requestable) -> Void)?
        public func execute(_ request: Requestable) async throws -> Data {
            onExecute?(request)
            if let returnError = returnError {
                throw returnError
            }
            return returnData
        }

        func getCache(fromRequest request: Requestable) throws -> Data? {
            return returnData
        }

        init() {
        }
    }

    func testAPIClent_makeRequest_responseSuccess() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let mockData = "Echo".data(using: .utf8)
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnData = mockData
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var requestBaseURL: String?
        var requestPath: String?
        var requestMethod: RequestMethod?

        mockSessionManager.onExecute = { request in
            requestBaseURL = request.baseURL
            requestPath = request.path
            requestMethod = request.method
        }

        var receivedData: Data?
        var receivedError: Error?
        do {
            receivedData = try await apiClient.execute(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertEqual(requestBaseURL, mockEndpoint.baseURL)
        XCTAssertEqual(requestPath, mockEndpoint.path)
        XCTAssertEqual(requestMethod, mockEndpoint.method)
        XCTAssertEqual(receivedData, mockData)
        XCTAssertNil(receivedError)
    }

    func testAPIClent_makeRequest_responseFailure() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let mockError: NetworkError = .invalidResponse
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnError = mockError
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var requestBaseURL: String?
        var requestPath: String?
        var requestMethod: RequestMethod?

        mockSessionManager.onExecute = { request in
            requestBaseURL = request.baseURL
            requestPath = request.path
            requestMethod = request.method
        }

        var receivedData: Data?
        var receivedError: Error?
        do {
            receivedData = try await apiClient.execute(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertEqual(requestBaseURL, mockEndpoint.baseURL)
        XCTAssertEqual(requestPath, mockEndpoint.path)
        XCTAssertEqual(requestMethod, mockEndpoint.method)
        XCTAssertNil(receivedData)
        guard let receivedError = receivedError as? NetworkError else {
            XCTFail("Error type mismatched")
            return
        }
        XCTAssertEqual(receivedError, mockError)
    }

    func testAPIClent_getObject_withParsedModal() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let testModel = TestModel(date: "2022-01-07", title: "Networking")
        let mockData = try JSONEncoder().encode(testModel)
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnData = mockData
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var receivedData: TestModel!
        var receivedError: Error?
        do {
            receivedData = try await apiClient.getObject(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertEqual(receivedData, testModel)
        XCTAssertNil(receivedError)
    }

    func testAPIClent_getList_withParsedModal() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let testModel = [TestModel(date: "2022-01-06",
                                   title: "Networking 1"),
                         TestModel(date: "2022-01-07",
                                   title: "Networking 2")]
        let mockData = try JSONEncoder().encode(testModel)
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnData = mockData
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var receivedData: [TestModel]!
        var receivedError: Error?
        do {
            receivedData = try await apiClient.getList(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertEqual(receivedData, testModel)
        XCTAssertNil(receivedError)
    }

    func testAPIClent_getObject_withInvalidData() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let mockData = "Invalid JSON".data(using: .utf8)
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnData = mockData
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var receivedData: TestModel!
        var receivedError: Error?
        do {
            receivedData = try await apiClient.getObject(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertNil(receivedData)
        XCTAssertNotNil(receivedError)
    }

    func testAPIClent_getList_withInvalidData() async throws {
        // given
        let mockEndpoint = EndpointsMock.mockData
        let mockData = "Invalid JSON".data(using: .utf8)
        let mockSessionManager = SessionManagerMock()
        mockSessionManager.returnData = mockData
        let apiClient = DefaultAPIClient(sessionManager: mockSessionManager)

        // when
        var receivedData: [TestModel]!
        var receivedError: Error?
        do {
            receivedData = try await apiClient.getList(mockEndpoint)
        } catch {
            receivedError = error
        }

        // then
        XCTAssertNil(receivedData)
        XCTAssertNotNil(receivedError)
    }
}
