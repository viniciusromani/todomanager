//
//  ToDoManagerModels.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

struct DisplayedTask {
    let title: String
    let completionDate: String?
    let color: UIColor
}

struct ToDoManager {
    struct FetchTasks {
        struct Request { }
        struct Response {
            let availableTasks: [ListTask]
            let completedTasks: [ListTask]
        }
        struct ViewModel {
            let availableTasks: [DisplayedTask]
            let completedTasks: [DisplayedTask]
        }
    }
    
    struct WillDeleteTask {
        struct Request {
            let section: ToDoTableView.Section
            let selectedRow: Int
        }
        struct Response {
            let section: ToDoTableView.Section
            let selectedRow: Int
        }
        struct ViewModel {
            let title: String
            let message: String
            let yesActionData: (title: String, style: UIAlertActionStyle)
            let noActionData: (title: String, style: UIAlertActionStyle)
            let section: ToDoTableView.Section
            let selectedRow: Int
        }
    }
    
    struct DeleteTask {
        struct Request {
            let section: ToDoTableView.Section
            let selectedRow: Int
        }
        struct Response {
            struct Success {
                let availableTasks: [ListTask]
                let completedTasks: [ListTask]
            }
            struct Error {
                let localizedMessage: String
            }
        }
        struct ViewModel {
            struct Success {
                let availableTasks: [DisplayedTask]
                let completedTasks: [DisplayedTask]
            }
            struct Error {
                let title: String
                let message: String
            }
        }
    }
    
    struct DidSelectRow {
        struct Request {
            let section: ToDoTableView.Section
            let selectedRow: Int
        }
        struct Response { }
        struct ViewModel { }
    }
}
