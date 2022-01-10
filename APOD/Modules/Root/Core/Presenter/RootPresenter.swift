//
//  RootPresenter.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import DataModel
import Networking

protocol RootPresenter: AnyObject {
    func viewDidLoad()
    func openDatePicker()
}

final class RootPresenterImpl: RootPresenter {
    weak var view: RootView?
    var interactor: RootInteractor
    var router: RootRouter

    // states
    private var displayDate: Date {
        didSet {
            self.loadPicture()
        }
    }

    private var runningTask: Task<(), Never>?

    init(view: RootView,
         interactor: RootInteractor,
         router: RootRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.displayDate = Date()
    }

    func viewDidLoad() {
        self.loadPicture(isFirstLoad: true)
    }

    func openDatePicker() {
        router.openDatePicker(initialDate: displayDate) { [weak self] date in
            guard let self = self else { return }
            self.displayDate = date
        }
    }

    private func loadPicture(isFirstLoad: Bool = false) {
        guard ProcessInfo().environment["UITesting"] == nil else {
            return
        }

        runningTask?.cancel()

        let date = self.displayDate
        runningTask = Task { [weak self] in
            guard let self = self else { return }
            do {
                await self.view?.showLoadingIndicator()
                let result = try await self.interactor.loadPicture(onDate: date)
                guard !Task.isCancelled else { return }
                await self.view?.pictureContentDidLoad(result)
                self.runningTask = nil
                await self.view?.hideLoadingIndicator()
            } catch let _ as CancellationError {
                await self.view?.hideLoadingIndicator()
            } catch {
                if isFirstLoad, let networkError = error as? NetworkError {
                    // if API failed at the first time, the selected date will be subtracted by 1 day.
                    log("networkError = \(networkError)")
                    switch networkError {
                    case .unacceptedCode(let status, _, let data) where 400..<500 ~= status:
                        let errorMessage = String(data: data, encoding: .utf8)
                        // TODO: extract max date from API
                        self.displayDate = self.displayDate.addingTimeInterval(-24 * 60 * 60)
                    default:
                        await self.view?.hideLoadingIndicator()
                        await self.view?.showError(message: "Unable load picture on this date....")
                    }
                } else {
                    await self.view?.hideLoadingIndicator()
                    await self.view?.showError(message: "Unable load picture on this date....")
                }
            }
        }
    }

    deinit {
        runningTask?.cancel()
    }
}
