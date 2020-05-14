//
//  PreGameViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 02/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

enum gameState {
    case nextTeam, nextRound
}

let prevLvl: [String] = [
    "В ПЕРВОМ РАУНДЕ ОБЪЯСНЯЙТЕ ПОЯВЛЯЮЩИЕСЯ НА ЭКРАНЕ СЛОВА БЕЗ ИСПОЛЬЗОВАНИЯ ОДНОКОРЕННЫХ И СОЗВУЧНЫХ",
    "ВО ВТОРОМ РАУНДЕ ПОКАЗЫВАЙТЕ ПОЯВЛЯЮЩИЕСЯ НА ЭКРАНЕ СЛОВА БЕЗ ИСПОЛЬЗОВАНИЯ УСТНОЙ РЕЧИ",
    "В ТРЕТЬЕМ РАУНДЕ ОБЪЯСНЯЙТЕ ПОЯВЛЯЮЩИЕСЯ НА ЭКРАНЕ СЛОВА НА ОСНОВЕ АСОЦИАЦИЙ, ВОЗНИКШИХ В ПРОШЛЫХ РАУНДАХ"
]

class PreGameViewController: UIViewController {
    
    @IBOutlet weak var labelRule: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var buttonPlay: UIButton!
    
    
    private lazy var alert: AlertBack = {
        let alertView: AlertBack = AlertBack.loadFromNib()
        alertView.delegate = self
        return alertView
    }()
    
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var curTeamIndex = 0
    
    var maxCountWord = 0
    var curIndexWord = 0
    
    var arrayTeams: [TeamStruct] = []
    var arrayWords: [WordStruct] = []
    
    var curLvl = 0
    var curState: gameState!
    
    
    private func updateCollectionView()
    {
        for i in 0..<arrayTeams.count
        {
            arrayTeams[i].imageName = "\(arrayTeams[i].teamIndicator)" + "pers"
        }
        arrayTeams[curTeamIndex].imageName += "Active"
        collectionView.reloadData()
    }
    
    
    private func initNewRound() {
        curIndexWord = 0
        arrayWords.shuffle()
        if curLvl == 2 {
            print("Good Bye!!!!")
        } else {
            curLvl += 1
        }
    }
    
    
    private func getCurGameState() {
        
        print()
        curTeamIndex = (curTeamIndex + 1) % arrayTeams.count
        
        if (curIndexWord < arrayWords.count - 1) {
            let unusedWord = arrayWords[curIndexWord]
            for i in curIndexWord..<(arrayWords.count - 1) {
                arrayWords[i] = arrayWords[i + 1]
            }
            arrayWords[arrayWords.count - 1] = unusedWord
        }
        
        switch curState {
        case .nextTeam?: print(curTeamIndex, "\narray = \(arrayWords), count = \(arrayWords.count) \n", arrayTeams.count)
        case .nextRound?: initNewRound()
        case .none: print("upps")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        alert.delegate = self
        
        setupVisualEffectView()
        
        getCurGameState()
        updateCollectionView()
        
        buttonPlay.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonPlay.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpInside, .touchCancel])
        
        maxCountWord = arrayWords.count
        imageTeam.image = UIImage(named: arrayTeams[curTeamIndex].imageName + "Select")
        labelRule.text = prevLvl[curLvl]
        
        countTop += 1
    }
    
    @objc fileprivate func animationOut(sender: UIButton) {
        UIView.animate(withDuration: 0.3,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }


    @objc fileprivate func animationIn(sender: UIButton) {
        UIView.animate(withDuration: 0.2,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           if #available(iOS 13.0, *) {
               return .darkContent
           } else {
               return .default
           }
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    
    func setAlert() {
        view.addSubview(alert)
        alert.center = view.center
    }
    
    
    func animateIn() {
        alert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alert.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alert.alpha = 1
            self.alert.transform = CGAffineTransform.identity
        }
    }
    
    
    func animateOut() {
        UIView.animate(withDuration: 0.4,
                       animations: {
                        self.visualEffectView.alpha = 0
                        self.alert.alpha = 0
                        self.alert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.alert.removeFromSuperview()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "3e" {
            let gameVC: GameViewController = segue.destination as! GameViewController
            
            gameVC.modalPresentationStyle = .currentContext
            
            gameVC.arrayWords = arrayWords
            gameVC.arrayTeams = arrayTeams
            gameVC.curIndexWord = curIndexWord
            gameVC.maxCountWord = maxCountWord
            gameVC.curTeamIndex = curTeamIndex
            gameVC.curLvl = curLvl
        }
    }
    
    
    @IBAction func backMainMaenu(_ sender: Any) {
        setAlert()
        animateIn()
    }
}


extension PreGameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    AlertBackDelegate
{
    func leftActionButton() {
        print("left")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenuVC = storyBoard.instantiateViewController(withIdentifier: "mainMenu") as! MainMenuViewController
        
        mainMenuVC.modalPresentationStyle = .currentContext
        self.present(mainMenuVC, animated: true, completion: nil)
    }
    
    func rightActionButton() {
        print("right")
        animateOut()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTeams.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamStartCell", for: indexPath) as? TeamStartCollectionViewCell {
            itemCell.newTeam = arrayTeams[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = (collectionViewLayout as! UICollectionViewFlowLayout)
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
