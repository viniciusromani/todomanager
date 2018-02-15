//
//  TaskCoreDataStore.swift
//  ToDoList
//
//  Created by Vinicius Romani on 15/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskCoreDataStore: TaskStoreProtocol {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveTask(_ task: ListTask) {
        let context = appDelegate.persistentContainer.viewContext
        
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newTask = NSManagedObject(entity: taskEntity!, insertInto: context)
        
        newTask.setValue(task.name, forKey: "name")
//        newTask.setValue(task.name, forKey: "category")
        newTask.setValue(task.status, forKey: "status")
        newTask.setValue(task.completionDate, forKey: "completionDate")
        
        do {
            try context.save()
        } catch {
            print("Task Entity was not saved")
        }
    }
}
