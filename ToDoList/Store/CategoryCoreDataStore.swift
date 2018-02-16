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
        guard let categoryEntity = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as? Category else {
            errorHandler(NSError(domain: "Invalid Category Entity", code: 400, userInfo: nil))
            return
        }
        categoryEntity.name = category.name
        categoryEntity.color = category.color
        
        do {
            try context.save()
            successHandler()
        } catch let error {
            errorHandler(error)
        }
    }
}
