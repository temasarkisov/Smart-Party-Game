//
//  arrayWordsStruct.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/10/2019.
//  Copyright © 2019 Paw.toporkov. All rights reserved.
//

import Foundation

struct ArrayWordsStruct
{
    
    var arrayWords: [WordStruct]  // Массив структур
    var length: Int               // Длина массива структур
    
    // Инициализация
    init()
    {
        length = 0
        arrayWords = []
    }
}
