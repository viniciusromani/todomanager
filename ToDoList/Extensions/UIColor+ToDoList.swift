//
//  UIColor+ToDoList.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var tdLightGreen: UIColor {
        return UIColor(red: 198.0 / 255.0, green: 218.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }
    
    class var tdDarkGreen: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 167.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    class var tdOrange: UIColor {
        return UIColor(red: 246.0 / 255.0, green: 139.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    }
    
    class var tdYellow: UIColor {
        return UIColor(red: 226.0 / 255.0, green: 180.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    class var tdRed: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 82.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
    }
    
    class var tdPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 110.0 / 255.0, blue: 131.0 / 255.0, alpha: 1.0)
    }
}

// MARK: - Helper to be used in core data

extension UIColor {
    class func color(withData data: Data?) -> UIColor? {
        guard let dat = data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: dat) as? UIColor
    }
    
    func encoded() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}



