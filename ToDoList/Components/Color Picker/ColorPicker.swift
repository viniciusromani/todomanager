//
//  ColorPicker.swift
//  ToDoList
//
//  Created by Vinicius Romani on 16/02/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol ColorPickerDelegate {
    func didChangeColor(in picker: UIView, _ color: UIColor)
}

class ColorPicker: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    var colorPickerDelegate: ColorPickerDelegate?
    
    private var colorMapper: [(index: Int, color: UIColor)] = [
        (index: 0, color: UIColor.tdLightGreen),
        (index: 1, color: UIColor.tdDarkGreen),
        (index: 2, color: UIColor.tdOrange),
        (index: 3, color: UIColor.tdYellow),
        (index: 4, color: UIColor.tdRed),
        (index: 5, color: UIColor.tdPink),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed(R.nib.colorPicker.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        slider.addTarget(self, action: #selector(roundValue), for: .valueChanged)
    }
    
    @objc func roundValue() {
        slider.value = round(slider.value)
    }
    
    // MARK: - Event Handling
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let index = Int(sender.value)
        let selectedColor = colorMapper[index].color
        colorView.backgroundColor = selectedColor
        colorPickerDelegate?.didChangeColor(in: self, selectedColor)
    }
}

