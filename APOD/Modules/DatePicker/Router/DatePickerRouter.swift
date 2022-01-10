//
//  DatePickerRouter.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation

protocol DatePickerRouter {
    func dismiss(withDate date: Date) 
}

protocol DatePickerRouteNavigatable: AnyObject {
    func dismiss()
}

final class DatePickerRouterImpl: DatePickerRouter {
    weak var controller: DatePickerRouteNavigatable?
    private var onDateChange: (Date) -> Void

    init(controller: DatePickerRouteNavigatable,
         onDateChange: @escaping (Date) -> Void) {
        self.controller = controller
        self.onDateChange = onDateChange
    }

    func dismiss(withDate date: Date) {
        self.onDateChange(date)
        controller?.dismiss()
    }
}
