//
//  ListPresenter.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import SwiftUI
import DataModel

protocol ListPresenter: AnyObject {
    func viewDidLoad()
}

class ListPresenterImpl: ListPresenter {
    weak var view: ListView?
    var interactor: ListInteractor
    var router: ListRouter

    private var runningTask: Task<(), Never>?

    init(view: ListView,
         interactor: ListInteractor,
         router: ListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        let today = Date()
        self.loadLastDays(today, days: 7)
    }

    private func loadLastDays(_ date: Date, days: Int) {
        runningTask?.cancel()

        runningTask = Task { [weak self] in
            guard let self = self else { return }
            do {
                await self.view?.showLoadingIndicator()
                let result = try await self.interactor.loadLastDays(date, days: days)
                guard !Task.isCancelled else { return }
                await self.view?.pictureListDidLoad(result)
                self.runningTask = nil
                await self.view?.hideLoadingIndicator()
            } catch let _ as CancellationError {
                await self.view?.hideLoadingIndicator()
            } catch {
                await self.view?.hideLoadingIndicator()
                await self.view?.showError(message: "Unable load picture on this date....")
            }
        }
    }

    deinit {
        runningTask?.cancel()
    }
}
