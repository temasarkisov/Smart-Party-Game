//
//  labelPoint.swift
//  SmartGame
//
//  Created by Paw.toporkov on 25/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

@IBDesignable
class labelPoint: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
