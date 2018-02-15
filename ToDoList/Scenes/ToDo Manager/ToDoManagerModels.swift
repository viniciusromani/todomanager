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
            let availableTasks: [Task]
            let completedTasks: [Task]
        }
        struct ViewModel {
            let availableTasks: [DisplayedTask]
            let completedTasks: [DisplayedTask]
        }
    }
    
    struct WillDeleteTask {
        struct Request {
            let selectedIndexPath: IndexPath
        }
        struct Response {
            let selectedIndexPath: IndexPath
        }
        struct ViewModel {
            let title: String
            let message: String
            let yesActionData: (title: String, style: UIAlertActionStyle)
            let noActionData: (title: String, style: UIAlertActionStyle)
            let selectedIndexPath: IndexPath
        }
    }
    
    struct DeleteTask {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            let availableTasks: [Task]
            let completedTasks: [Task]
        }
        struct ViewModel {
            let availableTasks: [DisplayedTask]
            let completedTasks: [DisplayedTask]
        }
    }
}
