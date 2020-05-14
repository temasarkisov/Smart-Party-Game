//
//  AlertBack.swift
//  SmartGame
//
//  Created by Paw.toporkov on 20/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

protocol AlertBackDelegate: class
{
    func leftActionButton()
    func rightActionButton()
}

class AlertBack: UIView
{
    var delegate: AlertBackDelegate?
    
    @IBOutlet weak var leftButton: backButton!
    @IBOutlet weak var rightButton: backButton!
    
    @IBAction func leftActionButton(_ sender: Any) {
        delegate?.leftActionButton()
    }
    
    @IBAction func rightActionButton(_ sender: Any) {
        delegate?.rightActionButton()
    }
}
