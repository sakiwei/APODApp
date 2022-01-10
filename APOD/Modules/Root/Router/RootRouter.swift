//
//  RootRouter.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import UIKit

protocol RootRouter {
    func openDatePicker(initialDate: Date,
                        onDateChange: @escaping (Date) -> Void)
}

protocol RootRouteNavigatable: AnyObject {
    func present(withDatePicker datePicker: UIViewController)
}

final class RootRouterImpl: RootRouter {
    weak var controller: RootRouteNavigatable?

    init(controller: RootRouteNavigatable) {
        self.controller = controller
    }

    func openDatePicker(initialDate: Date, onDateChange: @escaping (Date) -> Void) {
        let datePicker = datePicker(withDate: initialDate,
                                    onDateChange: onDateChange)
        controller?.present(withDatePicker: datePicker)
    }

    private func datePicker(withDate date: Date,
                            onDateChange: @escaping (Date) -> Void) -> UIViewController {
        return DatePickerModuleBuilderImpl().build(withDate: date,
                                                   onDateChange: onDateChange)
    }
}
