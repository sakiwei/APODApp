//
//  APODEnpoints.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import Networking

enum APODEndpoints {
    // get the astronomy picture on a date (date format: YYYY-MM-DD)
    case pictureOnDate(apiKey: String, date: String)
}

extension APODEndpoints: Requestable {
    
    var baseURL: String {
        return "https://api.nasa.gov"
    }
    
    var path: String {
        switch self {
        case .pictureOnDate:
            return "/planetary/apod"
        }
    }
    
    var data: [String: String] {
        switch self {
        case .pictureOnDate(let apiKey, let date):
            return [
                "api_key": apiKey,
                "date": date
            ]
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .GET
        }
    }
}
