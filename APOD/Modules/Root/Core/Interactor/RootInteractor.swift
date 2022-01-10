//
//  RootInteractor.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import Networking
import DataModel

protocol RootInteractor: AnyObject {
    func loadPicture(onDate date: Date) async throws -> AstronomyPicture
}

final class RootInteractorImpl: RootInteractor {
    weak var presenter: RootPresenter?
    private var service: FetchDailyPictureService

    init(service: FetchDailyPictureService) {
        self.service = service
    }

    func loadPicture(onDate date: Date) async throws -> AstronomyPicture {
        do {
            return try await service.fetchPicture(onDate: date)
        } catch {
            // use disk cache if request failed or device disconnected
            guard let picture = try service.loadCachedPicture(onDate: date) else {
                // cache not found, throw error
                throw error
            }
            return picture
        }
    }
}
