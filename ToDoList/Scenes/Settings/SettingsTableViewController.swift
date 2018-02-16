//
//  SettingsTableViewController.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol SettingsTableViewControllerInput {
    func displayStoredColor(_ viewModel: Settings.StoreColor.ViewModel)
    func displaySavedCategory(_ viewModel: Settings.SaveCategory.ViewModel.Success)
    func displayErrorOnSaving(_ viewModel: Settings.SaveCategory.ViewModel.Error)
}

protocol SettingsTableViewControllerOutput {
    func storeColor(_ request: Settings.StoreColor.Request)
    func saveCategory(_ request: Settings.SaveCategory.Request)
}

class SettingsTableViewController: UITableViewController {
    var output: SettingsTableViewControllerOutput!
    var router: SettingsRouter!
    
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        SettingsConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorPickerDelegate()
    }
    

    // MARK: - Event handling

    @IBAction func cancelButtonTouchedUp(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTouchedUp(_ sender: UIButton) {
        saveCategory(categoryNameTextField.text ?? "")
    }
}

// MARK: - Display logic

extension SettingsTableViewController: SettingsTableViewControllerInput {
    
    func displayStoredColor(_ viewModel: Settings.StoreColor.ViewModel) { }
    
    func displaySavedCategory(_ viewModel: Settings.SaveCategory.ViewModel.Success) {
        let okAction = AlertActionBuilder(dismissWithTitle: "OK").build()
        let alert = AlertBuilder()
                    .setTitle(viewModel.title)
                    .setMessage(viewModel.message)
                    .setAction(okAction)
                    .build()
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayErrorOnSaving(_ viewModel: Settings.SaveCategory.ViewModel.Error) {
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

extension SettingsTableViewController: ColorPickerDelegate {
    func didChangeColor(in picker: UIView, _ color: UIColor) {
        storeColor(color)
    }
}

// MARK: - Helpers

extension SettingsTableViewController {
    
    private func setColorPickerDelegate() {
        colorPicker.colorPickerDelegate = self
    }
    
    private func storeColor(_ color: UIColor) {
        let request = Settings.StoreColor.Request(color: color)
        output.storeColor(request)
    }
    
    private func saveCategory(_ name: String) {
        let request = Settings.SaveCategory.Request(name: name)
        output.saveCategory(request)
    }
}







