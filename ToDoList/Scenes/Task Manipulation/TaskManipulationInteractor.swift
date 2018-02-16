//
//  TaskManipulationInteractor.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol TaskManipulationInteractorInput {
    var flow: Flow { get }
    var selectedTask: ListTask? { get }
    
    func fetchInitialState(_ request: TaskManipulation.FetchInitialState.Request)
    func fetchTaskData(_ request: TaskManipulation.FetchTaskData.Request)
    func storeColor(_ request: TaskManipulation.StoreColor.Request)
    func addTask(_ request: TaskManipulation.AddTask.Request)
}

protocol TaskManipulationInteractorOutput {
    func presentInitialState(_ response: TaskManipulation.FetchInitialState.Response)
    func presentTaskData(_ response: TaskManipulation.FetchTaskData.Response)
    
    func presentStoredColor(_ response: TaskManipulation.StoreColor.Response)
    
    func presentAddedTask(_ response: TaskManipulation.AddTask.Response.Success)
    func presentErrorOnAdding(_ response: TaskManipulation.AddTask.Response.Error)
}

class TaskManipulationInteractor: TaskManipulationInteractorInput {
    var output: TaskManipulationInteractorOutput!
    var flow: Flow = .none
    var selectedTask: ListTask?
    private var selectedColor: UIColor = UIColor.tdLightGreen
    let taskWorker = TaskWorker(store: TaskCoreDataStore())
    
    // MARK: - Business logic
    
    func fetchInitialState(_ request: TaskManipulation.FetchInitialState.Request) {
        let response = TaskManipulation.FetchInitialState.Response(flow: flow)
        output.presentInitialState(response)
    }
    
    func fetchTaskData(_ request: TaskManipulation.FetchTaskData.Request) {
        guard let task = selectedTask else { return }
        let response = TaskManipulation.FetchTaskData.Response(task: task)
        output.presentTaskData(response)
    }
    
    func storeColor(_ request: TaskManipulation.StoreColor.Request) {
        selectedColor = request.color
        
        let response = TaskManipulation.StoreColor.Response()
        output.presentStoredColor(response)
    }
    
    func addTask(_ request: TaskManipulation.AddTask.Request) {
        let category = ListCategory(name: request.categoryName,
                                    color: selectedColor)
        let task = ListTask(name: request.name,
                            completionDate: Date(withDayMonthYear: request.completionDate ?? ""),
                            category: category,
                            status: request.status)
        
        taskWorker.saveTask(task, successHandler: {
            let response = TaskManipulation.AddTask.Response.Success()
            self.output.presentAddedTask(response)
        }) { error in
            let response = TaskManipulation.AddTask.Response.Error(localizedError: error?.localizedDescription ?? "")
            self.output.presentErrorOnAdding(response)
        }
    }
}
