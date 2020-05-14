//
//  TopicCollectionView.swift
//  SmartGame
//
//  Created by Paw.toporkov on 16/03/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class TopicCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setDefaultNameImage(name: inout String) {
        let countUnneedSym = Array(name).index(of: "A") ?? -1
        if countUnneedSym != -1 {
            name.removeLast(name.count - countUnneedSym)
        }
        
    }
    
    func setDefaultTopic(topic: inout TopicStruct) {
        topic.checkActiv = false
        let countUnneedSym = Array(topic.nameImage).index(of: "A") ?? -1
        if countUnneedSym != -1 {
            topic.nameImage.removeLast(topic.nameImage.count - countUnneedSym)
        }
    }
    
    func setSelectedTopic(topic: inout TopicStruct) {
        topic.checkActiv = true
        let needSym = Array(topic.nameImage).index(of: "A") ?? -1
        if needSym == -1 {
            topic.nameImage += "Active"
        }
    }
    
    
    
    var indexTopic: [Int] = []
    var arrayTopic: [TopicStruct] = []
    var countSelectedTopic: Int = 0

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = UIColor.clear
        delegate = self
        dataSource = self
        register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc private func reload() {
        self.reloadData()
    }
    
    
    private func initDefalteTopic(topic: inout TopicStruct) {
        let checkActiv = Array(topic.nameImage).index(of: "A") ?? -1
        if checkActiv != -1 {
            topic.nameImage.removeLast(topic.nameImage.count - checkActiv)
        }
        topic.checkActiv = false
    }
    
    
    @objc fileprivate func test(sender: UIButton) {
        if arrayTopic[sender.tag].checkActiv {
            initDefalteTopic(topic: &arrayTopic[sender.tag])
            let v = indexTopic.firstIndex(of: sender.tag)
            if v != nil {
                indexTopic.remove(at: v!)
                countSelectedTopic -= 1
            }
            
        } else if countSelectedTopic < 3 {
            arrayTopic[sender.tag].nameImage += "Active"
            arrayTopic[sender.tag].checkActiv = true
            countSelectedTopic += 1
            indexTopic.append(sender.tag)
        }
        sender.setImage(UIImage(named: arrayTopic[sender.tag].nameImage), for: .normal)
    }
    
    
    @objc fileprivate func animationOut(sender: UIButton) {
        UIView.animate(withDuration: 0.3,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }


    @objc fileprivate func animationIn(sender: UIButton) {
        UIView.animate(withDuration: 0.1,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    
    func set(cells: [TopicStruct]) {
        self.arrayTopic = cells
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        arrayTopic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.reuseId, for: indexPath) as! TopicCollectionViewCell
        
        cell.button.tag = indexPath.item
        cell.button.imageView?.contentMode = .scaleAspectFit
        cell.button.setImage(UIImage(named: arrayTopic[indexPath.item].nameImage), for: .normal)
        cell.button.contentVerticalAlignment = .fill
        cell.button.contentHorizontalAlignment = .fill
        cell.button.imageView?.clipsToBounds = true
        cell.button.clipsToBounds = true
        cell.button.contentMode = .scaleAspectFit
        cell.button.adjustsImageWhenHighlighted = false
        cell.button.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.width)
        
        if arrayTopic[indexPath.item].isPurchased {
            cell.button.alpha = 1.0
        } else {
            cell.button.alpha = 0.5
        }
        
        cell.button.addTarget(self, action: #selector(test(sender:)), for: .touchUpInside)
        cell.button.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        cell.button.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        cell.label.frame = CGRect.init(x: 0, y: cell.frame.width, width: cell.frame.width, height: cell.frame.height - cell.frame.width)
        cell.label.textAlignment = .center
        cell.label.text = arrayTopic[indexPath.item].nameTopic
        cell.label.font = UIFont(name: "LucidaGrande-Bold", size: 15)
        cell.label.textColor = UIColor.black
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.frame.size.height
        return CGSize(width: height * 0.4, height: height * 0.47)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellSpacing = self.frame.width * 0.07
        return UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
}

