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
    func presentDeletedTask(_ response: ToDoManager.DeleteTask.Response.Success)
    func presentErrorOnDelete(_ response: ToDoManager.DeleteTask.Response.Error)
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
        let response = ToDoManager.WillDeleteTask.Response(section: request.section,
                                                           selectedRow: request.selectedRow)
        output.presentWillDeleteTask(response)
    }
    
    func deleteTask(_ request: ToDoManager.DeleteTask.Request) {
        
        var selectedTask: ListTask
        switch request.section {
            case .available:
                selectedTask = currentAvailableTasks[request.selectedRow]
                currentAvailableTasks.remove(at: request.selectedRow)
            case .completed:
                selectedTask = currentCompletedTasks[request.selectedRow]
                currentCompletedTasks.remove(at: request.selectedRow)
        }
        
        tasksWorker.deleteTask(selectedTask, successHandler: {
            let response = ToDoManager.DeleteTask.Response.Success(availableTasks: self.currentAvailableTasks,
                                                                   completedTasks: self.currentCompletedTasks)
            self.output.presentDeletedTask(response)
        }) { error in
            let response = ToDoManager.DeleteTask.Response.Error(localizedMessage: error?.localizedDescription ?? "")
            self.output.presentErrorOnDelete(response)
        }
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
