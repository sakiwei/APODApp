//
//  StringUtils.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation

// MARK: - Regex helpers
extension String {
    func toRegex() -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: self, options: .anchorsMatchLines)
        } catch let error {
            fatalError("Error constructing regular expression: \(error)")
        }
    }

    subscript(matchPattern pattern: String) -> [NSTextCheckingResult] {
        let nsString = self as NSString
        let results = pattern.toRegex().matches(in: self,
                                                options: [],
                                                range: NSRange(location: 0, length: nsString.length))
        return results
    }
}

// MARK: Youtube content extract
extension String {
    var youtubeID: String? {
        let result = self[matchPattern: #"^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$"#]
        if !result.isEmpty {
            let nsString = self as NSString
            return nsString.substring(with: result[0].range(at: 5))
        }
        return nil
    }
}
