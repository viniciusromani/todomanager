//
//  CategoryWorker.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

class CategoryWorker {
    
    private var store: CategoryStoreProtocol
    
    init(store: CategoryStoreProtocol) {
        self.store = store
    }
    
    func saveCategory(_ category: ListCategory,
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping(_ error: Error?) -> Void) {
        store.saveCategory(category, successHandler: successHandler, errorHandler: errorHandler)
    }
}

protocol CategoryStoreProtocol {
    func saveCategory(_ category: ListCategory,
                  successHandler: @escaping () -> Void,
                  errorHandler: @escaping(_ error: Error?) -> Void)
}
