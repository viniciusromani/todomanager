//
//  TaskManipulationViewController.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol TaskManipulationViewControllerInput {
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel)
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel)
}

protocol TaskManipulationViewControllerOutput {
    var flow: Flow { get set }
    var selectedTask: Task? { get set }
    
    func fetchInitialState(_ request: TaskManipulation.FetchInitialState.Request)
    func fetchTaskData(_ request: TaskManipulation.FetchTaskData.Request)
}

class TaskManipulationViewController: UIViewController {
    var output: TaskManipulationViewControllerOutput!
    var router: TaskManipulationRouter!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        TaskManipulationConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchInitialState()
    }
    
    // MARK: - Event Handling
    
    @IBAction func deleteButtonTouchedUp(_ sender: UIButton) {
        
    }
}

// MARK: - Display logic

extension TaskManipulationViewController: TaskManipulationViewControllerInput {
    
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel) {
        navigationController?.title = viewModel.navigationTitle
        deleteButton.isHidden = !viewModel.shouldShowDeleteButton
        
        guard viewModel.flow == .isEditingTask else { return }
        let request = TaskManipulation.FetchTaskData.Request()
        output.fetchTaskData(request)
    }
    
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel) {
        taskNameTextField.text = viewModel.taskName
        categoryNameTextField.text = viewModel.categoryName
    }
}

// MARK: - Helper

extension TaskManipulationViewController {
    
    private func fetchInitialState() {
        let request = TaskManipulation.FetchInitialState.Request()
        output.fetchInitialState(request)
    }
}


