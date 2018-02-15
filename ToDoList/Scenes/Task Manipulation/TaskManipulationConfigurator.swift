//
//  TaskManipulationConfigurator.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension TaskManipulationViewController: TaskManipulationPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension TaskManipulationInteractor: TaskManipulationViewControllerOutput {
}

extension TaskManipulationPresenter: TaskManipulationInteractorOutput {
}

class TaskManipulationConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = TaskManipulationConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: TaskManipulationViewController) {
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
