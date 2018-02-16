//
//  ToDoManagerRouter.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ToDoManagerRouterInput {
    func navigateToTaskDetails()
}

class ToDoManagerRouter: ToDoManagerRouterInput {
    weak var viewController: ToDoManagerViewController!
    
    let addTaskSegue = R.segue.toDoManagerViewController.addTaskSegue
    let taskDetailsSegue = R.segue.toDoManagerViewController.taskDetailsSegue
    
    // MARK: - Navigation
    
    func navigateToTaskDetails() {
        viewController.performSegue(withIdentifier: taskDetailsSegue, sender: nil)
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        switch segue.identifier {
        case addTaskSegue.identifier?:
            passDataToAddTaskScene(segue: segue)
        case taskDetailsSegue.identifier?:
            passDataToTaskDetailsScene(segue: segue)
        default: break
        }
    }
}

// MARK: - Helper

extension ToDoManagerRouter {
    private func passDataToAddTaskScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router how to pass data to the next scene
        guard let addTaskViewController = segue.destination as? TaskManipulationTableViewController else { return }
        addTaskViewController.output.flow = .isAddingTask
        addTaskViewController.output.selectedTask = viewController.output.selectedTask
    }
    
    private func passDataToTaskDetailsScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router how to pass data to the next scene
        guard let addTaskViewController = segue.destination as? TaskManipulationTableViewController else { return }
        addTaskViewController.output.flow = .isEditingTask
        addTaskViewController.output.selectedTask = viewController.output.selectedTask
    }
}
