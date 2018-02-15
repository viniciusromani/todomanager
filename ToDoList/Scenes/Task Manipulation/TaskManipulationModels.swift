//
//  TaskManipulationModels.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

struct TaskManipulation {
    struct FetchInitialState {
        struct Request { }
        struct Response {
            let flow: Flow
        }
        struct ViewModel {
            let flow: Flow
            let navigationTitle: String
            let shouldShowDeleteButton: Bool
        }
    }
    
    struct FetchTaskData {
        struct Request { }
        struct Response {
            let task: Task
        }
        struct ViewModel {
            let taskName: String
            let categoryName: String
        }
    }
}
