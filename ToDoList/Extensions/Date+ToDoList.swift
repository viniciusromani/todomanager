//
//  Date+ToDoList.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

public extension Date {
    var dayMonthYearStringValue: String {
        return DateFormatter.dayMonthYearFormat.string(from: self)
    }
}
