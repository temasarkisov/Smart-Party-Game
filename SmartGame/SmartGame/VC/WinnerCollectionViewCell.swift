//
//  WinnerCollectionViewCell.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class WinnerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func findA(str: String) -> Bool
    {
        for char in str
        {
            if char == "A"
            {
                return true
            }
        }
        return false
    }
    
    var team: TeamStruct!
    {
        didSet
        {
            label.text = "\(team!.pointsNumber)"
            image.image = UIImage(named: team!.imageName)
            if findA(str: team!.imageName)
            {
                label.backgroundColor = #colorLiteral(red: 1, green: 0.8199352622, blue: 0.7513111234, alpha: 1)
            }
            else
            {
                label.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
            }
        }
    }
    
}
