//
//  TaskManipulationPresenter.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol TaskManipulationPresenterInput {
    func presentInitialState(_ response: TaskManipulation.FetchInitialState.Response)
    func presentTaskData(_ response: TaskManipulation.FetchTaskData.Response)
}

protocol TaskManipulationPresenterOutput: class {
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel)
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel)
}

class TaskManipulationPresenter: TaskManipulationPresenterInput {
    weak var output: TaskManipulationPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentInitialState(_ response: TaskManipulation.FetchInitialState.Response) {
        switch response.flow {
        case .isAddingTask:
            let viewModel = TaskManipulation.FetchInitialState.ViewModel(flow: response.flow,
                                                                         navigationTitle: "Add Task",
                                                                         buttonState: .add)
            output.displayInitialState(viewModel)
        case .isEditingTask:
            let viewModel = TaskManipulation.FetchInitialState.ViewModel(flow: response.flow,
                                                                         navigationTitle: "Task Details",
                                                                         buttonState: .delete)
            output.displayInitialState(viewModel)
        default: break
        }
    }
    
    
    func presentTaskData(_ response: TaskManipulation.FetchTaskData.Response) {
        let task = response.task
        let viewModel = TaskManipulation.FetchTaskData.ViewModel(taskName: task.name,
                                                                 categoryName: task.category.name)
        output.displayTaskData(viewModel)
    }
}
