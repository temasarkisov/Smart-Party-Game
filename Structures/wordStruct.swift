//
//  wordStruct.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/10/2019.
//  Copyright © 2019 Paw.toporkov. All rights reserved.
//

import Foundation

struct WordStruct
{
    var word: String  // Слово
    var points: Int    // Количество очков за угаданное слово
    
    init()
    {          // Инициализация
        word = ""
        points = 0
    }
}
