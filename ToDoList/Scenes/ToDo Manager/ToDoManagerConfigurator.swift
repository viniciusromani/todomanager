//
//  ToDoManagerConfigurator.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ToDoManagerViewController: ToDoManagerPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension ToDoManagerInteractor: ToDoManagerViewControllerOutput {
}

extension ToDoManagerPresenter: ToDoManagerInteractorOutput {
}

class ToDoManagerConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = ToDoManagerConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: ToDoManagerViewController) {
        let router = ToDoManagerRouter()
        router.viewController = viewController
        
        let presenter = ToDoManagerPresenter()
        presenter.output = viewController
        
        let interactor = ToDoManagerInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
