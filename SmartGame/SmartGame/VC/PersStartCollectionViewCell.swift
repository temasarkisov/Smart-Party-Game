//
//  PersStartCollectionViewCell.swift
//  SmartGame
//
//  Created by Paw.toporkov on 02/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class TeamStartCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageTeamStart: UIImageView!
    
    @IBOutlet weak var labelPointsStart: UILabel!
    
    var newTeam: TeamStruct!
    {
        didSet
        {
            imageTeamStart.image = UIImage(named: newTeam!.imageName)
            labelPointsStart.text = "\(newTeam!.pointsNumber)"
        }
    }
    
}
