//
//  DatePickerPresenter.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation

protocol DatePickerPresenter: AnyObject {
    func viewDidLoad()
    func dismiss()
    func change(selectedDate: Date)
    var selectedDate: Date { get }
}

final class DatePickerPresenterImpl: DatePickerPresenter {
    weak var view: DatePickerView?
    var interactor: DatePickerInteractor
    var router: DatePickerRouter

    // states
    private(set) var selectedDate: Date

    init(view: DatePickerView,
         interactor: DatePickerInteractor,
         router: DatePickerRouter,
         selectedDate: Date) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.selectedDate = selectedDate
    }

    func viewDidLoad() {
        self.view?.datePickerDidUpdate(selectedDate)
    }

    func dismiss() {
        self.router.dismiss(withDate: self.selectedDate)
    }

    func change(selectedDate: Date) {
        self.selectedDate = selectedDate
        log("selectedDate = \(selectedDate)")
    }
}
