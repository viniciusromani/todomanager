//
//  AlertBuilder.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import UIKit

// Alert Builder
class AlertBuilder {
    private var alert: UIAlertController!
    
    init() {
        alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert )
    }
    
    func setTitle(_ title: String?) -> AlertBuilder {
        alert.title = title
        return self
    }
    
    func setMessage(_ message: String?) -> AlertBuilder {
        alert.message = message
        return self
    }
    
    func setAction(_ action: UIAlertAction?) -> AlertBuilder {
        guard let act = action else { return self }
        alert.addAction(act)
        return self
    }
    
    func setActions(_ actions: [UIAlertAction]?) -> AlertBuilder {
        guard let acts = actions else { return self }
        for action in acts {
            alert.addAction(action)
        }
        return self
    }
    
    func build() -> UIAlertController {
        return alert
    }
}

// Action Builder
class AlertActionBuilder {
    private var action: UIAlertAction!
    
    init(with handler: @escaping (UIAlertAction) -> Void) {
        action = UIAlertAction(title: nil, style: .default, handler: handler)
    }
    init(dismissWithTitle title: String?) {
        action = UIAlertAction(title: title, style: .default, handler: nil)
    }
    
    func build() -> UIAlertAction {
        return action
    }
}
