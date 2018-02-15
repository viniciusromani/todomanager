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
    
    func saveTask(_ task: ListTask,
                  successHandler: @escaping () -> Void,
                  errorHandler: @escaping(_ error: Error?) -> Void) {
        
        let context = appDelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newTask = NSManagedObject(entity: taskEntity!, insertInto: context)
        
        newTask.setValue(task.name, forKey: "name")
//        newTask.setValue(task.name, forKey: "category")
        newTask.setValue(task.status, forKey: "status")
        newTask.setValue(task.completionDate, forKey: "completionDate")
        
        do {
            try context.save()
            successHandler()
        } catch let error {
            errorHandler(error)
        }
    }
    
    func fetchCompletedTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void) {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.predicate = NSPredicate(format: "status == YES")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var tasks: [ListTask] = []
            for data in result as! [NSManagedObject] {
                let task = ListTask(with: data)
                tasks.append(task)
            }
            successHandler(tasks)
        } catch let error {
            errorHandler(error)
        }
    }
    
    func fetchAvailableTasks(successHandler: @escaping (_ tasks: [ListTask]) -> Void,
                             errorHandler: @escaping(_ error: Error?) -> Void) {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.predicate = NSPredicate(format: "status == FALSE")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var tasks: [ListTask] = []
            for data in result as! [NSManagedObject] {
                let task = ListTask(with: data)
                tasks.append(task)
            }
            successHandler(tasks)
        } catch let error {
            errorHandler(error)
        }
    }
}
