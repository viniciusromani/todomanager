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
    
    func saveTask(_ task: ListTask,
                  successHandler: @escaping () -> Void,
                  errorHandler: @escaping(_ error: Error?) -> Void) {
        store.saveTask(task, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func fetchCompletedTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void) {
        store.fetchCompletedTasks(successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func fetchAvailableTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void) {
        store.fetchAvailableTasks(successHandler: successHandler, errorHandler: errorHandler)
    }
}

protocol TaskStoreProtocol {
    func saveTask(_ task: ListTask,
                  successHandler: @escaping () -> Void,
                  errorHandler: @escaping(_ error: Error?) -> Void)
    
    func fetchCompletedTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void)
    
    func fetchAvailableTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void)
}


