//
//  DateFormatter+ToDoList.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static var base: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }
    static var dayMonthYearFormat: DateFormatter {
        let formatter = DateFormatter.base
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
}
