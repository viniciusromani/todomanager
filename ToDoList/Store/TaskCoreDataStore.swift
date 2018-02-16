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
        guard let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as? Task else {
            errorHandler(NSError(domain: "Invalid Task Entity", code: 400, userInfo: nil))
            return
        }
        guard let categoryEntity = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as? Category else {
            errorHandler(NSError(domain: "Invalid Category Entity", code: 400, userInfo: nil))
            return
        }
        categoryEntity.name = task.category?.name
        categoryEntity.color = taskEntity.category?.color
        
        taskEntity.category = categoryEntity
        taskEntity.name = task.name
        taskEntity.status = task.status
        taskEntity.completionDate = task.completionDate
        
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
    
    func deleteTask(_ task: ListTask, successHandler: @escaping () -> Void, errorHandler: @escaping (Error?) -> Void) {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        let predicate = NSPredicate(format: "name == %@ AND status == %@", task.name, task.status as CVarArg)
        
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(request)
        for data in result as! [NSManagedObject] {
            context.delete(data)
        }
        
        do {
            try context.save()
            successHandler()
        } catch let error {
            errorHandler(error)
        }
    }
}


