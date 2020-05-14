//
//  topicStruct.swift
//  SmartGame
//
//  Created by Paw.toporkov on 10/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import Foundation

public var countTop = 0

struct TopicStruct
{
    var nameTopic: String
    var nameFile: String
    var nameImage: String
    var checkActiv: Bool
    var isPurchased: Bool
    var active: Bool
    
    init(curNameTopic: String, curNameFile: String, curNameImage: String, curIsPurchased: Bool) {
        nameTopic = curNameTopic
        nameFile = curNameFile
        nameImage = curNameImage
        checkActiv = false
        isPurchased = curIsPurchased
        active = false
    }
}
