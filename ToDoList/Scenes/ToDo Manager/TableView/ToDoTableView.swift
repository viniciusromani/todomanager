//
//  ToDoTableView.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol ToDoTableViewDelegate {
    func configure(toDoTableView tableView: ToDoTableView)
    func didSelect(tableView table: UITableView, at indexPath: IndexPath)
    func willDeleteItem(at indexPath: IndexPath, in tableView: UITableView)
}

class ToDoTableView: UITableView {
    
    private enum Section {
        case available
        case completed
    }
    private let sectionMapper: [Section] = [.available, .completed]
    
    var displayedAvailableTasks: [DisplayedTask] = [] {
        didSet {
            reloadData()
        }
    }
    var displayedCompletedTasks: [DisplayedTask] = [] {
        didSet {
            reloadData()
        }
    }
    
    var customDelegate: ToDoTableViewDelegate?
}

extension ToDoTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDelegate?.didSelect(tableView: tableView, at: indexPath)
    }
}

extension ToDoTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let availableTasksSection = displayedAvailableTasks.count > 0 ? 1: 0
        let completedTasksSection = displayedCompletedTasks.count > 0 ? 1: 0
        return availableTasksSection + completedTasksSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let enumSection = sectionMapper[section]
        switch enumSection {
        case .available: return displayedAvailableTasks.count
        case .completed: return displayedCompletedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = R.reuseIdentifier.toDoTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) else {
            return UITableViewCell()
        }
        
        var displayedTask: DisplayedTask
        let enumSection = sectionMapper[indexPath.section]
        switch enumSection {
            case .available: displayedTask = displayedAvailableTasks[indexPath.row]
            case .completed: displayedTask = displayedCompletedTasks[indexPath.row]
        }
        cell.configure(with: displayedTask)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let enumSection = sectionMapper[section]
        switch enumSection {
        case .available: return "Available Tasks"
        case .completed: return "Completed Tasks"
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        customDelegate?.willDeleteItem(at: indexPath, in: tableView)
    }
}
