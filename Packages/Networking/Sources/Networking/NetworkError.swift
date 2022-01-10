//
//  NetworkError.swift
//  
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation

public enum NetworkError: Error {
    case malformedURL
    case notConnectedToInternet
    case cancelled
    case invalidResponse
    case unacceptedCode(status: Int, response: HTTPURLResponse, data: Data)
    case generic(Error)
}

extension NetworkError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.malformedURL, .malformedURL):
            return true
        case (.notConnectedToInternet, .notConnectedToInternet):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.unacceptedCode(let lStatus,
                              let lResponse,
                              let lData),
                .unacceptedCode(let rStatus,
                                let rResponse,
                                let rData)):
            return lStatus == rStatus && lResponse === rResponse && lData == rData
        default:
            return false
        }
    }
}
