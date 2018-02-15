//
//  TaskManipulationModels.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

enum ButtonState {
    case add
    case delete
}

struct TaskManipulation {
    struct FetchInitialState {
        struct Request { }
        struct Response {
            let flow: Flow
        }
        struct ViewModel {
            let flow: Flow
            let navigationTitle: String
            let buttonState: ButtonState
        }
    }
    
    struct FetchTaskData {
        struct Request { }
        struct Response {
            let task: ListTask
        }
        struct ViewModel {
            let taskName: String
            let categoryName: String
            let completionDate: String
            let isCompleted: Bool
        }
    }
}
