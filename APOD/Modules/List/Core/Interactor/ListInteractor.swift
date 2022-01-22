//
//  ListInteractor.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import Networking
import DataModel

protocol ListInteractor {
    func loadLastDays(_ date: Date, days: Int) async throws -> [AstronomyPicture]
}

class ListInteractorImpl: ListInteractor {
    weak var presenter: ListPresenter?

    private var service: FetchDailyPictureService

    init(service: FetchDailyPictureService) {
        self.service = service
    }

    func loadLastDays(_ date: Date, days: Int) async throws -> [AstronomyPicture] {
        let dayList: [Date] = (0..<days).map { dayOffset in date.addingTimeInterval(TimeInterval(dayOffset * -86400)) }
        return try await withThrowingTaskGroup(of: AstronomyPicture.self) { group -> [AstronomyPicture] in
            var apodList: [AstronomyPicture] = []
            apodList.reserveCapacity(dayList.count)
            for date in dayList {
                group.addTask {
                    print(date)
                    return try await self.service.fetchPictureOrCache(onDate: date)
                }
            }
            for try await result in group {
                apodList.append(result)
            }

            return apodList.sortedDesc(by: \.date)
        }
    }
}
