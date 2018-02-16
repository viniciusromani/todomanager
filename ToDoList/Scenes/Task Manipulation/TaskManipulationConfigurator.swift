//
//  TaskManipulationConfigurator.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension TaskManipulationTableViewController: TaskManipulationPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension TaskManipulationInteractor: TaskManipulationTableViewControllerOutput {
}

extension TaskManipulationPresenter: TaskManipulationInteractorOutput {
}

class TaskManipulationConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = TaskManipulationConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: TaskManipulationTableViewController) {
        let router = TaskManipulationRouter()
        router.viewController = viewController
        
        let presenter = TaskManipulationPresenter()
        presenter.output = viewController
        
        let interactor = TaskManipulationInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
