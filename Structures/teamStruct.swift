//
//  teamStruct.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/10/2019.
//  Copyright © 2019 Paw.toporkov. All rights reserved.
//

import Foundation

enum LevelType
{
    case easy, hard, all, noLvl
}

struct TeamStruct
{
    
    var teamIndicator: Int  // Индикатор команды
    var pointsNumber: Int  // Количество очков команды
    var skipNumber: Int    // Количество пропусков у команды
    var imageName: String
    
    init()
    {
        // Инициализация
        teamIndicator = 0
        pointsNumber = 0
        skipNumber = 0
        imageName = ""
    }
}
