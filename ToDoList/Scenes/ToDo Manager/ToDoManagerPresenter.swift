//
//  ToDoManagerPresenter.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ToDoManagerPresenterInput {
    func presentTasks(_ response: ToDoManager.FetchTasks.Response)
    func presentWillDeleteTask(_ response: ToDoManager.WillDeleteTask.Response)
    func presentDeletedTask(_ response: ToDoManager.DeleteTask.Response)
}

protocol ToDoManagerPresenterOutput: class {
    func displayTasks(_ viewModel: ToDoManager.FetchTasks.ViewModel)
    func displayWillDeleteTask(_ viewModel: ToDoManager.WillDeleteTask.ViewModel)
    func displayDeletedTask(_ viewModel: ToDoManager.DeleteTask.ViewModel)
}

class ToDoManagerPresenter: ToDoManagerPresenterInput {
    weak var output: ToDoManagerPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentTasks(_ response: ToDoManager.FetchTasks.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        let available = tasksToDisplayedTasks(response.availableTasks)
        let completed = tasksToDisplayedTasks(response.completedTasks)
        
        let viewModel = ToDoManager.FetchTasks.ViewModel(availableTasks: available,
                                                         completedTasks: completed)
        output.displayTasks(viewModel)
    }
    
    func presentWillDeleteTask(_ response: ToDoManager.WillDeleteTask.Response) {
        let viewModel = ToDoManager.WillDeleteTask.ViewModel(title: "Delete",
                                                             message: "Are you sure you want to delete?",
                                                             yesActionData: (title: "Yes", style: .default),
                                                             noActionData: (title: "No", style: .default),
                                                             selectedIndexPath: response.selectedIndexPath)
        output.displayWillDeleteTask(viewModel)
    }
    
    func presentDeletedTask(_ response: ToDoManager.DeleteTask.Response) {
        let available = tasksToDisplayedTasks(response.availableTasks)
        let completed = tasksToDisplayedTasks(response.completedTasks)
        
        let viewModel = ToDoManager.DeleteTask.ViewModel(availableTasks: available,
                                                         completedTasks: completed)
        output.displayDeletedTask(viewModel)
    }
}

// MARK: - Helper

extension ToDoManagerPresenter {
    private func taskToDisplayedTask(_ task: Task) -> DisplayedTask {
        let displayedTask = DisplayedTask(title: task.name,
                                          completionDate: task.completionDate?.dayMonthYearStringValue,
                                          color: UIColor.green)
        return displayedTask
    }
    private func tasksToDisplayedTasks(_ tasks: [Task]) -> [DisplayedTask] {
        return tasks.flatMap { return taskToDisplayedTask($0) }
    }
}
