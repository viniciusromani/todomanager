//
//  SettingsPresenter.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol SettingsPresenterInput {
    func presentStoredColor(_ response: Settings.StoreColor.Response)
    func presentSavedCategory(_ response: Settings.SaveCategory.Response.Success)
    func presentErrorOnSaving(_ response: Settings.SaveCategory.Response.Error)
}

protocol SettingsPresenterOutput: class {
    func displayStoredColor(_ viewModel: Settings.StoreColor.ViewModel)
    func displaySavedCategory(_ viewModel: Settings.SaveCategory.ViewModel.Success)
    func displayErrorOnSaving(_ viewModel: Settings.SaveCategory.ViewModel.Error)
}

class SettingsPresenter: SettingsPresenterInput {
    weak var output: SettingsPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentStoredColor(_ response: Settings.StoreColor.Response) {
        let viewModel = Settings.StoreColor.ViewModel()
        output.displayStoredColor(viewModel)
    }
    
    func presentSavedCategory(_ response: Settings.SaveCategory.Response.Success) {
        let viewModel = Settings.SaveCategory.ViewModel.Success(title: "Success", message: "Category successfully saved!")
        output.displaySavedCategory(viewModel)
    }
    
    func presentErrorOnSaving(_ response: Settings.SaveCategory.Response.Error) {
        let viewModel = Settings.SaveCategory.ViewModel.Error(title: "Error", message: response.localizedError)
        output.displayErrorOnSaving(viewModel)
    }
}
