//
//  Request.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

// MARK: - Request Method

public enum RequestMethod {
    case GET
    // TODO: support POST method in future
}

extension RequestMethod: CustomStringConvertible {
    public var description: String {
        switch self {
        case .GET:
            return "GET"
        }
    }
}

// MARK: - Request

public protocol Requestable {
    var method: RequestMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var data: [String: String] { get }
}

// MARK: - Endpoint

extension Requestable {
    var URL: String {
        return self.baseURL + self.path
    }
}
