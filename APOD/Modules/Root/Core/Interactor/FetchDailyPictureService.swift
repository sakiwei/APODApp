//
//  FetchDailyPictureService.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import Networking
import DataModel

protocol FetchDailyPictureService {
    func fetchPicture(onDate date: Date) async throws -> AstronomyPicture
    func loadCachedPicture(onDate date: Date) throws -> AstronomyPicture?
}

final class FetchDailyPictureServiceImpl: FetchDailyPictureService {
    private let apiClient: APIClient
    private let enviroment: Enviroment

    init(enviroment: Enviroment, apiClient: APIClient) {
        self.enviroment = enviroment
        self.apiClient = apiClient
    }

    func fetchPicture(onDate date: Date) async throws -> AstronomyPicture {
        return try await self.apiClient.getObject(createRequest(withDate: date))
    }

    func loadCachedPicture(onDate date: Date) throws -> AstronomyPicture? {
        return try self.apiClient.getCachedObject(createRequest(withDate: date))
    }

    private func createRequest(withDate date: Date) -> Requestable {
        APODEndpoints.pictureOnDate(apiKey: enviroment.nasaApodKey,
                                    date: transformDateValue(withDate: date))
    }

    private func transformDateValue(withDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
