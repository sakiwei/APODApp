//
//  DatePickerViewController.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation
import UIKit
import FoundationKit
import ViewKit
import Kingfisher

final class DatePickerViewController: UIViewController, ViewSafe {
    typealias ViewType = DatePickerContentView
    var presenter: DatePickerPresenter!

    override func loadView() {
        super.loadView()
        view = createTypeSafeView()
        typeSafeView.onDateChange = { [weak self] date in
            guard let self = self else { return }
            self.presenter.change(selectedDate: date)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
        self.preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    override func viewWillLayoutSubviews() {
        let size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.preferredContentSize = rect.integral.size
        super.viewWillLayoutSubviews()
    }

    deinit {
    }
}

extension DatePickerViewController: DatePickerView {
    func datePickerDidUpdate(_ date: Date) {
        self.typeSafeView.datePicker.date = date
    }
}

extension DatePickerViewController: DatePickerRouteNavigatable {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DatePickerViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        self.presenter.dismiss()
        return false
    }
}
