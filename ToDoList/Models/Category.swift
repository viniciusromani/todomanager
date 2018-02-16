//
//  Category.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct ListCategory {
    let name: String
    let color: UIColor?
}

extension ListCategory {
    init?(with managedObject: NSManagedObject?) {
        guard let object = managedObject else { return nil }
        name = object.value(forKey: "name") as! String
        color = UIColor.color(withData: object.value(forKey: "color") as? Data)
    }
}
