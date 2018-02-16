//
//  SettingsConfigurator.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension SettingsTableViewController: SettingsPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension SettingsInteractor: SettingsTableViewControllerOutput {
}

extension SettingsPresenter: SettingsInteractorOutput {
}

class SettingsConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = SettingsConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: SettingsTableViewController) {
        let router = SettingsRouter()
        router.viewController = viewController
        
        let presenter = SettingsPresenter()
        presenter.output = viewController
        
        let interactor = SettingsInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
