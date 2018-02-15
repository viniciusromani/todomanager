//
//  ToDoManagerInteractor.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ToDoManagerInteractorInput {
    var selectedTask: ListTask? { get set }
    
    func fetchTasks(_ request: ToDoManager.FetchTasks.Request)
    func willDeleteTask(_ request: ToDoManager.WillDeleteTask.Request)
    func deleteTask(_ request: ToDoManager.DeleteTask.Request)
    func didSelectRow(_ request: ToDoManager.DidSelectRow.Request)
}

protocol ToDoManagerInteractorOutput {
    func presentTasks(_ response: ToDoManager.FetchTasks.Response)
    func presentWillDeleteTask(_ response: ToDoManager.WillDeleteTask.Response)
    func presentDeletedTask(_ response: ToDoManager.DeleteTask.Response)
    func presentSelectedRow(_ response: ToDoManager.DidSelectRow.Response)
}

class ToDoManagerInteractor: ToDoManagerInteractorInput {
    var output: ToDoManagerInteractorOutput!
    private var currentAvailableTasks: [ListTask] = []
    private var currentCompletedTasks: [ListTask] = []
    private let tasksWorker = TaskWorker(store: TaskCoreDataStore())
    
    var selectedTask: ListTask?
    
    // MARK: - Business logic
    
    func fetchTasks(_ request: ToDoManager.FetchTasks.Request) {
        
        // NOTE: Create some Worker to do the work
        tasksWorker.fetchCompletedTasks(successHandler: { tasks in
            // NOTE: Pass the result to the Presenter
            self.currentCompletedTasks = tasks
            let response = ToDoManager.FetchTasks.Response(availableTasks: self.currentAvailableTasks,
                                                           completedTasks: self.currentCompletedTasks)
            self.output.presentTasks(response)
        }) { error in
            
            //
        }
        
        tasksWorker.fetchAvailableTasks(successHandler: { tasks in
            // NOTE: Pass the result to the Presenter
            self.currentAvailableTasks = tasks
            let response = ToDoManager.FetchTasks.Response(availableTasks: self.currentAvailableTasks,
                                                           completedTasks: self.currentCompletedTasks)
            self.output.presentTasks(response)
        }) { error in
            
            //
        }
    }
    
    func willDeleteTask(_ request: ToDoManager.WillDeleteTask.Request) {
        let response = ToDoManager.WillDeleteTask.Response(selectedIndexPath: request.selectedIndexPath)
        output.presentWillDeleteTask(response)
    }
    
    func deleteTask(_ request: ToDoManager.DeleteTask.Request) {
        
        // TIRAR DO CORE DATA
        currentAvailableTasks.remove(at: 0)
        
        // PARTE COMUM
        let response = ToDoManager.DeleteTask.Response(availableTasks: currentAvailableTasks,
                                                       completedTasks: currentCompletedTasks)
        output.presentDeletedTask(response)
    }
    
    func didSelectRow(_ request: ToDoManager.DidSelectRow.Request) {
        switch request.section {
        case .available:
            selectedTask = currentAvailableTasks[request.selectedRow]
        case .completed:
            selectedTask = currentCompletedTasks[request.selectedRow]
        }
        
        let response = ToDoManager.DidSelectRow.Response()
        output.presentSelectedRow(response)
    }
}
