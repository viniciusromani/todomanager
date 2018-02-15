//
//  ToDoManagerInteractor.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ToDoManagerInteractorInput {
    func fetchTasks(_ request: ToDoManager.FetchTasks.Request)
    func willDeleteTask(_ request: ToDoManager.WillDeleteTask.Request)
    func deleteTask(_ request: ToDoManager.DeleteTask.Request)
}

protocol ToDoManagerInteractorOutput {
    func presentTasks(_ response: ToDoManager.FetchTasks.Response)
    func presentWillDeleteTask(_ response: ToDoManager.WillDeleteTask.Response)
    func presentDeletedTask(_ response: ToDoManager.DeleteTask.Response)
}

class ToDoManagerInteractor: ToDoManagerInteractorInput {
    var output: ToDoManagerInteractorOutput!
    private var currentAvailableTasks: [Task] = []
    private var currentCompletedTasks: [Task] = []
    
    // MARK: - Business logic
    
    func fetchTasks(_ request: ToDoManager.FetchTasks.Request) {
        // NOTE: Create some Worker to do the work
        let category = Category(id: 0, name: "testando", color: "z")
        let available1 = Task(name: "Buy bread", completionDate: nil, category: category, status: false)
        let available2 = Task(name: "Buy milk", completionDate: Date(), category: category, status: false)
        
        let completed1 = Task(name: "Buy car", completionDate: Date(), category: category, status: true)
        let completed2 = Task(name: "Buy house", completionDate: Date(), category: category, status: true)
        
        
        // FAZER O FETCH NO COREDATA
        
        
        // PARTE COMUM,
        currentAvailableTasks = [available1, available2]
        currentCompletedTasks = [completed1, completed2]
        
        // NOTE: Pass the result to the Presenter
        let response = ToDoManager.FetchTasks.Response(availableTasks: currentAvailableTasks,
                                                       completedTasks: currentCompletedTasks)
        output.presentTasks(response)
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
}