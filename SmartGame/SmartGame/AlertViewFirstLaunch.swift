//
//  AlertViewFirstLaunch.swift
//  SmartGame
//
//  Created by Paw.toporkov on 28/04/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

protocol AlertFirstLaunchDelegate: class {
    func actionButton()
}

class AlertViewFirstLaunch: UIView {
    
    var deligate: AlertFirstLaunchDelegate?
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func activeButton(_ sender: Any) {
        deligate?.actionButton()
    }
    
}
