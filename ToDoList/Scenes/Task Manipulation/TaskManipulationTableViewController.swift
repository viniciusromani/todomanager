//
//  TaskManipulationTableViewController.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol TaskManipulationTableViewControllerInput {
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel)
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel)
    func displayStoredColor(_ viewModel: TaskManipulation.StoreColor.ViewModel)
    func displayAddedTask(_ viewModel: TaskManipulation.AddTask.ViewModel.Success)
    func displayErrorOnAdding(_ viewModel: TaskManipulation.AddTask.ViewModel.Error)
    func displayDeletedTask(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Success)
    func displayErrorOnDeleting(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Error)
}

protocol TaskManipulationTableViewControllerOutput {
    var flow: Flow { get set }
    var selectedTask: ListTask? { get set }
    
    func fetchInitialState(_ request: TaskManipulation.FetchInitialState.Request)
    func fetchTaskData(_ request: TaskManipulation.FetchTaskData.Request)
    func storeColor(_ request: TaskManipulation.StoreColor.Request)
    func addTask(_ request: TaskManipulation.AddTask.Request)
    func deleteTask(_ request: TaskManipulation.DeleteTask.Request)
}

class TaskManipulationTableViewController: UITableViewController {
    var output: TaskManipulationTableViewControllerOutput!
    var router: TaskManipulationRouter!
    
    @IBOutlet weak var controlButton: UIButton!
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var completionDateTextField: UITextField!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    
    var buttonState: ButtonState = .delete {
        didSet {
            updateButtonAppearance()
        }
    }
    var currentColor: UIColor?
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        TaskManipulationConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorPickerDelegate()
        fetchInitialState()
    }
    
    // MARK: - Event Handling
    
    @IBAction func controlButtonTouchedUp(_ sender: UIButton) {
        switch buttonState {
        case .add: addTask()
        case .delete: deleteTask()
        }
    }
}

// MARK: - Display logic

extension TaskManipulationTableViewController: TaskManipulationTableViewControllerInput {
    
    func displayInitialState(_ viewModel: TaskManipulation.FetchInitialState.ViewModel) {
        title = viewModel.navigationTitle
        buttonState = viewModel.buttonState
        
        guard viewModel.flow == .isEditingTask else { return }
        let request = TaskManipulation.FetchTaskData.Request()
        output.fetchTaskData(request)
    }
    
    func displayTaskData(_ viewModel: TaskManipulation.FetchTaskData.ViewModel) {
        taskNameTextField.text = viewModel.taskName
        categoryNameTextField.text = viewModel.categoryName
        completionDateTextField.text = viewModel.completionDate
        isCompletedSwitch.setOn(viewModel.isCompleted, animated: true)
    }
    
    func displayStoredColor(_ viewModel: TaskManipulation.StoreColor.ViewModel) { }
    
    func displayAddedTask(_ viewModel: TaskManipulation.AddTask.ViewModel.Success) {
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        let alert = AlertBuilder()
                    .setTitle(viewModel.title)
                    .setMessage(viewModel.message)
                    .setAction(okAction)
                    .build()
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayErrorOnAdding(_ viewModel: TaskManipulation.AddTask.ViewModel.Error) {
        let okAction = AlertActionBuilder(dismissWithTitle: "OK").build()
        let alert = AlertBuilder()
                    .setTitle(viewModel.title)
                    .setMessage(viewModel.message)
                    .setAction(okAction)
                    .build()
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayDeletedTask(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Success) {
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        let alert = AlertBuilder()
                    .setTitle(viewModel.title)
                    .setMessage(viewModel.message)
                    .setAction(okAction)
                    .build()
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayErrorOnDeleting(_ viewModel: TaskManipulation.DeleteTask.ViewModel.Error) {
        let okAction = AlertActionBuilder(dismissWithTitle: "OK").build()
        let alert = AlertBuilder()
                    .setTitle(viewModel.title)
                    .setMessage(viewModel.message)
                    .setAction(okAction)
                    .build()
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ColorPicker Delegate

extension TaskManipulationTableViewController: ColorPickerDelegate {
    func didChangeColor(in picker: UIView, _ color: UIColor) {
        storeColor(color)
    }
}

// MARK: - Helper

extension TaskManipulationTableViewController {
    
    private func setColorPickerDelegate() {
        colorPicker.colorPickerDelegate = self
    }
    
    private func storeColor(_ color: UIColor) {
        let request = TaskManipulation.StoreColor.Request(color: color)
        output.storeColor(request)
    }
    
    private func fetchInitialState() {
        let request = TaskManipulation.FetchInitialState.Request()
        output.fetchInitialState(request)
    }
    
    private func updateButtonAppearance() {
        switch buttonState {
        case .add:
            controlButton.setTitle("Add Task", for: .normal)
            controlButton.setTitleColor(UIColor.blue, for: .normal)
        case .delete:
            controlButton.setTitle("Delete Task", for: .normal)
            controlButton.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    private func addTask() {
        let request = TaskManipulation.AddTask.Request(name: taskNameTextField.text ?? "",
                                                       categoryName: categoryNameTextField.text ?? "",
                                                       completionDate: completionDateTextField.text,
                                                       status: isCompletedSwitch.isOn)
        output.addTask(request)
    }
    
    private func deleteTask() {
        let request = TaskManipulation.DeleteTask.Request()
        output.deleteTask(request)
    }
}


