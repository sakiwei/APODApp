//
//  QueryUtils.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

extension Dictionary where Value == String, Key == String {
    public func queryString() -> String {
        Array(self.keys)
            .sorted()
            .map { key in
                var allowedCharactors: CharacterSet = .urlQueryAllowed
                allowedCharactors.remove(charactersIn: "?")
                if let key = key.addingPercentEncoding(withAllowedCharacters: allowedCharactors),
                   let value = self[key]?.addingPercentEncoding(withAllowedCharacters: allowedCharactors) {
                    return "\(key)=\(value)"
                } else {
                    return ""
                }
            }
            .filter { $0 != "" }
            .joined(separator: "&")
    }
}

extension URL {
    public func withQueries(_ queries: [String: String]) -> URL {
        guard !queries.isEmpty else {
            return self
        }
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = Array(queries.keys)
            .sorted().map { key in
                URLQueryItem(name: key, value: queries[key])
            }
        return components?.url ?? self
    }
}
