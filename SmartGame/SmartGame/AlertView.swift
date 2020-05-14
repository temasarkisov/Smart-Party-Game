//
//  AlertView.swift
//  SmartGame
//
//  Created by Paw.toporkov on 18/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

protocol AlertDelegate: class {
    func actionButton()
}

class AlertView: UIView {
    
    var deligate: AlertDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: buttonAlert!
    
    
    @IBAction func actionButton(_ sender: Any) {
        deligate?.actionButton()
    }
}
