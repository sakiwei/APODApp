//
//  APIClient.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

public protocol APIClient: AnyObject {
    var sessionManager: SessionManager { get }
    func execute(_ request: Requestable) async throws -> Data
    func getObject<T: Decodable>(_ request: Requestable) async throws -> T
    func getCachedObject<T: Decodable>(_ request: Requestable) throws -> T?
    func getCachedList<T: Decodable>(_ request: Requestable) throws -> [T]?
}

public class DefaultAPIClient: APIClient {
    public let sessionManager: SessionManager

    public func execute(_ request: Requestable) async throws -> Data {
        return try await self.sessionManager.execute(request)
    }

    public func getObject<T: Decodable>(_ request: Requestable) async throws -> T {
        let data = try await self.sessionManager.execute(request)
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func getList<T: Decodable>(_ request: Requestable) async throws -> [T] {
        let data = try await self.sessionManager.execute(request)
        return try JSONDecoder().decode([T].self, from: data)
    }

    public func getCachedObject<T: Decodable>(_ request: Requestable) throws -> T? {
        guard let data = try self.sessionManager.getCache(fromRequest: request) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func getCachedList<T: Decodable>(_ request: Requestable) throws -> [T]? {
        guard let data = try self.sessionManager.getCache(fromRequest: request) else {
            return nil
        }
        return try JSONDecoder().decode([T].self, from: data)
    }

    public init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
}
