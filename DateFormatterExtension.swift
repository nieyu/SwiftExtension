//
//  DateFormatterExtension.swift
//  YouBank
//
//  Created by  on 2019/6/23.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

extension DateFormatter {
    func string(timeInterval: TimeInterval,  dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        self.dateFormat = dateFormat
        let date: Date = Date.init(timeIntervalSince1970: timeInterval)
        return string(from: date)
    }
    func monthAndDayString(timeInterval: TimeInterval, dateFormat: String = "MM-dd") -> String {
        self.dateFormat = dateFormat
        let date: Date = Date.init(timeIntervalSince1970: timeInterval)
        return string(from: date)
    }
}
