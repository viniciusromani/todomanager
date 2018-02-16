//
//  CategoryCoreDataStore.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoryCoreDataStore: CategoryStoreProtocol {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveCategory(_ category: ListCategory,
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping (Error?) -> Void) {
        
        let context = appDelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let newTask = NSManagedObject(entity: taskEntity!, insertInto: context)
        
        newTask.setValue(category.name, forKey: "name")
        newTask.setValue(category.color.encoded(), forKey: "color")
        
        do {
            try context.save()
            successHandler()
        } catch let error {
            errorHandler(error)
        }
    }
}
