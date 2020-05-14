//
//  buttonAlert.swift
//  SmartGame
//
//  Created by Paw.toporkov on 18/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

@IBDesignable
class buttonAlert: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }

}
