//
//  TaskWorker.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

class TaskWorker {
    
    private var store: TaskStoreProtocol
    
    init(store: TaskStoreProtocol) {
        self.store = store
    }
    
    func saveTask(_ task: ListTask) {
        store.saveTask(task)
    }
}

protocol TaskStoreProtocol {
    func saveTask(_ task: ListTask)
}


