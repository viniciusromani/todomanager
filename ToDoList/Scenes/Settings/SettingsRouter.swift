//
//  SettingsRouter.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

protocol SettingsRouterInput {
    func navigateToSomewhere()
}

class SettingsRouter: SettingsRouterInput {
    weak var viewController: SettingsTableViewController!
    
    // MARK: - Navigation
    
    func navigateToSomewhere() {
        
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == "ShowSomewhereScene" {
            passDataToSomewhereScene(segue: segue)
        }
    }
    
    func passDataToSomewhereScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router how to pass data to the next scene
        
        // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
        // someWhereViewController.output.name = viewController.output.name
    }
}
