//
//  backButton.swift
//  SmartGame
//
//  Created by Paw.toporkov on 20/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

@IBDesignable
class backButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
