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
    func presentStoredColor(_ response: TaskManipulation.StoreColor.Response)
    func presentAddedTask(_ response: TaskManipulation.AddTask.Response.Success)
    func presentErrorOnAdding(_ response: TaskManipulation.AddTask.Response.Error)
    func presentDeletedTask(_ response: TaskManipulation.DeleteTask.Response.Success)
    func presentErrorOnDeleting(_ response: TaskManipulation.DeleteTask.Response.Error)
}

protocol TaskManipulationPresenterOutput: class {
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel)
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel)
    func displayStoredColor(_ viewModel: TaskManipulation.StoreColor.ViewModel)
    func displayAddedTask(_ viewModel: TaskManipulation.AddTask.ViewModel.Success)
    func displayErrorOnAdding(_ viewModel: TaskManipulation.AddTask.ViewModel.Error)
    func displayDeletedTask(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Success)
    func displayErrorOnDeleting(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Error)
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
                                                                 categoryName: task.category?.name ?? "",
                                                                 completionDate: task.completionDate?.dayMonthYearStringValue ?? "-",
                                                                 isCompleted: task.status)
        output.displayTaskData(viewModel)
    }
    
    func presentStoredColor(_ response: TaskManipulation.StoreColor.Response) {
        let viewModel = TaskManipulation.StoreColor.ViewModel()
        output.displayStoredColor(viewModel)
    }
    
    func presentAddedTask(_ response: TaskManipulation.AddTask.Response.Success) {
        let viewModel = TaskManipulation.AddTask.ViewModel.Success(title: "Success", message: "Task successfully saved!")
        output.displayAddedTask(viewModel)
    }
    
    func presentErrorOnAdding(_ response: TaskManipulation.AddTask.Response.Error) {
        let viewModel = TaskManipulation.AddTask.ViewModel.Error(title: "Error", message: response.localizedError)
        output.displayErrorOnAdding(viewModel)
    }
    
    func presentDeletedTask(_ response: TaskManipulation.DeleteTask.Response.Success) {
        let viewModel = TaskManipulation.DeleteTask.ViewModel.Success(title: "Success", message: "Task was deleted!")
        output.displayDeletedTask(viewModel)
    }
    
    func presentErrorOnDeleting(_ response: TaskManipulation.DeleteTask.Response.Error) {
        let viewModel = TaskManipulation.DeleteTask.ViewModel.Error(title: "Error", message: response.localizedError)
        output.displayErrorOnDeleting(viewModel)
    }
}
