//
//  WinnerViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {
    
    var winnerTeam: TeamStruct!
    var arrayTeams: [TeamStruct] = []
    
    var arrayOfSomething = ["lol", "novoselov", "sosat"]
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var labelPointWinner: labelPoint!
    
    @IBOutlet weak var imageWinnerTeam: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<arrayTeams.count
        {
            if arrayTeams[i].teamIndicator == winnerTeam.teamIndicator
            {
                arrayTeams[i].imageName = "\(arrayTeams[i].teamIndicator)" + "persActive"
            }
            else
            {
                arrayTeams[i].imageName = "\(arrayTeams[i].teamIndicator)" + "pers"
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self

        imageWinnerTeam.image = UIImage(named: "\(winnerTeam.teamIndicator)"+"persActiveSelect")
        labelPointWinner.text = "\(winnerTeam.pointsNumber)"
        
        
        leftButton.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        leftButton.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        rightButton.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        rightButton.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel])
        
    }
    
    
    @objc fileprivate func animationOut(sender: UIButton)
    {
        UIView.animate(withDuration: 0.3,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }


    @objc fileprivate func animationIn(sender: UIButton)
    {
        UIView.animate(withDuration: 0.1,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    

    @IBAction func goBackHome(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenuVC = storyBoard.instantiateViewController(withIdentifier: "5e") as! SelectedViewController
        mainMenuVC.modalPresentationStyle = .currentContext
        self.present(mainMenuVC, animated: true, completion: nil)
    }
    
    
   @IBAction func shareData(_ sender: Any) {
    
    animationOut(sender: sender as! UIButton)
        
        UIApplication.shared.windows.first!.rootViewController = self
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        //UIImageWriteToSavedPhotosAlbum(viewImage!, nil, nil, nil)
        let activityController = UIActivityViewController(activityItems: [viewImage ?? UIImage()], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    

}

extension WinnerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrayTeams.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamWinnerCell", for: indexPath) as? WinnerCollectionViewCell
        {
            itemCell.team = arrayTeams[indexPath.row]
            
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellSpacing = flowLayout.minimumInteritemSpacing
        let cellWidth = flowLayout.itemSize.width
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        
        let collectionViewWidth = collectionView.bounds.size.width
        
        let totalCellWidth = cellCount * cellWidth
        let totalCellSpacing = cellSpacing * (cellCount - 1)
        let totalCellsWidth = totalCellWidth + totalCellSpacing
        
        let edgeInsets = (collectionViewWidth - totalCellsWidth) / 2.0
        
        return edgeInsets > 0 ? UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets) : UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
}

