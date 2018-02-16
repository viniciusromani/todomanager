//
//  Date+ToDoList.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

public extension Date {
    init?(withDayMonthYear string: String) {
        if let date = DateFormatter.dayMonthYearFormat.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    var dayMonthYearStringValue: String {
        return DateFormatter.dayMonthYearFormat.string(from: self)
    }
}
