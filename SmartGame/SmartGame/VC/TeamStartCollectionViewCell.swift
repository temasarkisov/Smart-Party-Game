//
//  TeamStartCollectionViewCell.swift
//  SmartGame
//
//  Created by Paw.toporkov on 02/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class TeamStartCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageTeamStart: UIImageView!
    
    @IBOutlet weak var labelPointsStart: labelPoint!
    
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
    
    var newTeam: TeamStruct!
    {
        didSet
        {
            imageTeamStart.image = UIImage(named: newTeam!.imageName)
            labelPointsStart.text = "\(newTeam!.pointsNumber)"
            if findA(str: newTeam!.imageName)
            {
                labelPointsStart.backgroundColor = #colorLiteral(red: 1, green: 0.8199352622, blue: 0.7513111234, alpha: 1)
            }
            else
            {
                labelPointsStart.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
            }
        }
    }
    
}
