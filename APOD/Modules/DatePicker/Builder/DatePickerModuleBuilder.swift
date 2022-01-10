//
//  DatePickerModuleBuilder.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation
import UIKit
import Networking

protocol DatePickerModuleBuilder {
    func build(withDate date: Date,
               onDateChange: @escaping (Date) -> Void) -> UIViewController
}

final class DatePickerModuleBuilderImpl: DatePickerModuleBuilder {
    func build(withDate date: Date,
               onDateChange: @escaping (Date) -> Void) -> UIViewController {
        let view = DatePickerViewController()
        let interactor = DatePickerInteractorImpl()
        let router = DatePickerRouterImpl(controller: view, onDateChange: onDateChange)
        let presenter = DatePickerPresenterImpl(view: view,
                                                interactor: interactor,
                                                router: router,
                                                selectedDate: date)
        view.presenter = presenter
        return view
    }
}
