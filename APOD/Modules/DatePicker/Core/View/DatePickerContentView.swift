//
//  DatePickerContentView.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation
import UIKit
import SnapKit
import ViewKit

final class DatePickerContentView: UIView {
    let datePicker = UIDatePicker()
    let titleLabel = UILabel()

    var onDateChange: ((Date) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .systemBackground

        // add subviews
        [titleLabel, datePicker].forEach { view in
            addSubview(view)
        }

        createConstraints()
        stylingViews()

        // update subviews
        titleLabel.text = "Select a date"
        titleLabel.accessibilityIdentifier = "Select Date Title"
        datePicker.addTarget(self, action: #selector(onDateChange(_:)), for: .valueChanged)
        let today = Date()
        datePicker.maximumDate = today
        datePicker.accessibilityIdentifier = "Date Picker"
    }

    private func createConstraints() {
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(32)
            make.left.right.equalToSuperview().inset(32)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(titleLabel )
            make.bottom.equalToSuperview().inset(32)
        }
    }

    private func stylingViews() {
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true

        datePicker.datePickerMode = .date
        datePicker.tintColor = .systemOrange
    }

    @objc private func onDateChange(_ sender: UIDatePicker) {
        onDateChange?(datePicker.date)
    }
}
