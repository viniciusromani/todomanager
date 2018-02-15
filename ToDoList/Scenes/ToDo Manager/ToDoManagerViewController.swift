//
//  ToDoManagerViewController.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ToDoManagerViewControllerInput {
    func displayTasks(_ viewModel: ToDoManager.FetchTasks.ViewModel)
    func displayWillDeleteTask(_ viewModel: ToDoManager.WillDeleteTask.ViewModel)
    func displayDeletedTask(_ viewModel: ToDoManager.DeleteTask.ViewModel)
    func displaySelectedRow(_ viewModel: ToDoManager.DidSelectRow.ViewModel)
}

protocol ToDoManagerViewControllerOutput {
    var selectedTask: ListTask? { get }
    
    func fetchTasks(_ request: ToDoManager.FetchTasks.Request)
    func willDeleteTask(_ request: ToDoManager.WillDeleteTask.Request)
    func deleteTask(_ request: ToDoManager.DeleteTask.Request)
    func didSelectRow(_ request: ToDoManager.DidSelectRow.Request)
}

class ToDoManagerViewController: UIViewController {
    var output: ToDoManagerViewControllerOutput!
    var router: ToDoManagerRouter!

    @IBOutlet weak var toDoTableView: ToDoTableView!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        ToDoManagerConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(toDoTableView: toDoTableView)
        fetchTasks()
    }
}

// MARK: - Display logic

extension ToDoManagerViewController: ToDoManagerViewControllerInput {
    
    func displayTasks(_ viewModel: ToDoManager.FetchTasks.ViewModel) {
        // NOTE: Display the result from the Presenter
        toDoTableView.displayedAvailableTasks = viewModel.availableTasks
        toDoTableView.displayedCompletedTasks = viewModel.completedTasks
    }
    
    func displayWillDeleteTask(_ viewModel: ToDoManager.WillDeleteTask.ViewModel) {
        let yesAction = UIAlertAction(title: viewModel.yesActionData.title, style: viewModel.yesActionData.style) { action in
            let request = ToDoManager.DeleteTask.Request(indexPath: viewModel.selectedIndexPath)
            self.output.deleteTask(request)
        }
        let noAction = UIAlertAction(title: viewModel.noActionData.title, style: viewModel.noActionData.style)
        
        let willDeleteAlert = AlertBuilder()
                              .setTitle(viewModel.title)
                              .setMessage(viewModel.message)
                              .setActions([yesAction, noAction])
                              .build()
        present(willDeleteAlert, animated: true, completion: nil)
    }
    
    func displayDeletedTask(_ viewModel: ToDoManager.DeleteTask.ViewModel) {
        toDoTableView.displayedAvailableTasks = viewModel.availableTasks
        toDoTableView.displayedCompletedTasks = viewModel.completedTasks
    }
    
    func displaySelectedRow(_ viewModel: ToDoManager.DidSelectRow.ViewModel) {
        router.navigateToTaskDetails()
    }
}

// MARK: - TableView Custom Delegate

extension ToDoManagerViewController: ToDoTableViewDelegate {
    func configure(toDoTableView tableView: ToDoTableView) {
        tableView.delegate = tableView
        tableView.dataSource = tableView
        
        tableView.customDelegate = self
        tableView.register(R.nib.toDoTableViewCell)
    }
    
    func didSelect(tableView table: UITableView, at indexPath: IndexPath) {
        let request = ToDoManager.DidSelectRow.Request(section: toDoTableView.sectionMapper[indexPath.section],
                                                       selectedRow: indexPath.row)
        output.didSelectRow(request)
    }
    
    func willDeleteItem(at indexPath: IndexPath, in tableView: UITableView) {
        let request = ToDoManager.WillDeleteTask.Request(selectedIndexPath: indexPath)
        output.willDeleteTask(request)
    }
}

// MARK: - Helpers

extension ToDoManagerViewController {
    
    private func fetchTasks() {
        let request = ToDoManager.FetchTasks.Request()
        output.fetchTasks(request)
    }
}




