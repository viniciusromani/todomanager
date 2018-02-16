//
//  Task.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct ListTask {
    let name: String
    let completionDate: Date?
    let category: ListCategory
    let status: Bool
}

extension ListTask {
    init(with managedObject: NSManagedObject) {
        name = managedObject.value(forKey: "name") as! String
        completionDate = managedObject.value(forKey: "completionDate") as? Date
        category = ListCategory(name: "testando", color: UIColor.blue)
        status = managedObject.value(forKey: "status") as! Bool
    }
}
