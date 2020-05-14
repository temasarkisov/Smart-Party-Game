//
//  MyButton.swift
//  SmartGame
//
//  Created by Paw.toporkov on 11/04/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    private func ttt(topic: inout String) {
        let checkActiv = Array(topic).index(of: "A") ?? -1
        if checkActiv != -1 {
            topic.removeLast(topic.count - checkActiv)
        }
    }
    
    var nameImage: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        
        willSet {
            print("changing from \(isSelected) to \(newValue)")
        }

        didSet {
            print("changed from \(oldValue) to \(isSelected)")
        }
    }
}

