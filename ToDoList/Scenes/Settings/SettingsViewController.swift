//
//  SettingsViewController.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol SettingsViewControllerInput {
    
}

protocol SettingsViewControllerOutput {
    
}

class SettingsViewController: UIViewController {
    var output: SettingsViewControllerOutput!
    var router: SettingsRouter!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        SettingsConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Event Handling
    
    @IBAction func cancelButtonTouchedUp(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Display logic

extension SettingsViewController: SettingsViewControllerInput {
    
}
