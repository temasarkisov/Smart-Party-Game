//
//  Nib.swift
//  SmartGame
//
//  Created by Paw.toporkov on 18/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
