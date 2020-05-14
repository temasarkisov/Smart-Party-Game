//
//  TopicCollectionViewCell.swift
//  SmartGame
//
//  Created by Paw.toporkov on 11/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit


protocol topicDelegate: class {
    func selectedButton(_ sender: UIButton)
}

class TopicCollectionViewCell: UICollectionViewCell
{
    
    static let reuseId = "TopicCollectionViewCell"
    
    let label: UILabel = {
        var labelName = UILabel()
        //labelName.frame = CGRect.init(x: 0, y: self.width, width: self.frame.width, height: self.frame.height - self.frame.width)
        labelName.textAlignment = .center
        //itemCell.labelName.text = arrayTopic[indexPath.item].nameTopic
        return labelName
    }()
    
    let button: UIButton = {
        let curButton = UIButton()
        curButton.translatesAutoresizingMaskIntoConstraints = false
        return curButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(button)
        self.addSubview(label)
        
        //button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        //button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //button.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


