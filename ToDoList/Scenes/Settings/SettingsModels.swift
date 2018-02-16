//
//  SettingsModels.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright (c) 2018 Vinicius Romani. All rights reserved.
//

import UIKit

struct Settings {
    struct StoreColor {
        struct Request {
            let color: UIColor
        }
        struct Response { }
        struct ViewModel { }
    }
    
    struct SaveCategory {
        struct Request {
            let name: String
        }
        struct Response {
            struct Success { }
            struct Error {
                let localizedError: String
            }
        }
        struct ViewModel {
            struct Success {
                let title: String
                let message: String
            }
            struct Error {
                let title: String
                let message: String
            }
        }
    }
}
