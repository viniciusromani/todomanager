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
    var selectedTask: Task? { get }
    
    func fetchInitialState(_ request: TaskManipulation.FetchInitialState.Request)
    func fetchTaskData(_ request: TaskManipulation.FetchTaskData.Request)
}

protocol TaskManipulationInteractorOutput {
    func presentInitialState(_ response: TaskManipulation.FetchInitialState.Response)
    func presentTaskData(_ response: TaskManipulation.FetchTaskData.Response)
}

class TaskManipulationInteractor: TaskManipulationInteractorInput {
    var output: TaskManipulationInteractorOutput!
    var flow: Flow = .none
    var selectedTask: Task?
    
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
}
