//
//  DateUtils.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation

struct LocalizedDateFormat {
    var locale: Locale
    var format: String
}

extension String {
    func formatted(_ fromFormat: LocalizedDateFormat, to toFormat: LocalizedDateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = fromFormat.locale
        dateFormatter.dateFormat = fromFormat.format
        let date = dateFormatter.date(from: self)
        guard let date = date else {
            return nil
        }
        dateFormatter.locale = toFormat.locale
        dateFormatter.setLocalizedDateFormatFromTemplate(toFormat.format)
        return dateFormatter.string(from: date)
    }
}
