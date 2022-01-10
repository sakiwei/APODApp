//
//  DatePickerView.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation

protocol DatePickerView: AnyObject {
    func datePickerDidUpdate(_ date: Date)
}
