//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Vinicius Romani on 14/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with displayedTask: DisplayedTask?) {
        titleLabel.text = displayedTask?.title ?? "-"
        dateLabel.text = displayedTask?.completionDate ?? "-"
    }
}
