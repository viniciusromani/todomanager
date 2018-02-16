//
//  SettingsInteractor.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol SettingsInteractorInput {
    func storeColor(_ request: Settings.StoreColor.Request)
    func saveCategory(_ request: Settings.SaveCategory.Request)
}

protocol SettingsInteractorOutput {
    func presentStoredColor(_ response: Settings.StoreColor.Response)
    func presentSavedCategory(_ response: Settings.SaveCategory.Response.Success)
    func presentErrorOnSaving(_ response: Settings.SaveCategory.Response.Error)
}

class SettingsInteractor: SettingsInteractorInput {
    var output: SettingsInteractorOutput!
    private var selectedColor: UIColor = UIColor.tdLightGreen
    private let categoryWorker = CategoryWorker(store: CategoryCoreDataStore())
    
    // MARK: - Business logic
    
    func storeColor(_ request: Settings.StoreColor.Request) {
        selectedColor = request.color
        
        let response = Settings.StoreColor.Response()
        output.presentStoredColor(response)
    }
    
    func saveCategory(_ request: Settings.SaveCategory.Request) {
        let category = ListCategory(name: request.name, color: selectedColor)
        
        categoryWorker.saveCategory(category, successHandler: {
            let response = Settings.SaveCategory.Response.Success()
            self.output.presentSavedCategory(response)
        }) { error in
            let response = Settings.SaveCategory.Response.Error(localizedError: error?.localizedDescription ?? "")
            self.output.presentErrorOnSaving(response)
        }
    }
}
