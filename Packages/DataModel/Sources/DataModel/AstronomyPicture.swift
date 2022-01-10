//
//  AstronomyPicture.swift
//  
//
//  Created by Sakiwei on 7/1/2022.
//

import Foundation

public struct AstronomyPicture: Codable {
    public let date: String
    public let explanation: String
    public let mediaType: String
    public let serviceVersion: String
    public let title: String
    public let url: String
    public let copyright: String?
    public let hdurl: String?

    public enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
        case hdurl
    }

    public init(
        copyright: String,
        date: String,
        explanation: String,
        mediaType: String,
        serviceVersion: String,
        title: String,
        url: String,
        hdurl: String? = nil
    ) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.title = title
        self.url = url
        self.hdurl = hdurl
    }
}

extension AstronomyPicture: Equatable {
    
}
