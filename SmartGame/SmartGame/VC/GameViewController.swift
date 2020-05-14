//
//  GameViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 31/01/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    
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
    
    
    var check = 0
    var temp = 0
    
    
    @IBOutlet weak var labelWord: UILabel!
    @IBOutlet weak var labelPoint: UILabel!
    
    @IBOutlet weak var labelWordsOk: UILabel!
    @IBOutlet weak var labelWordsSkip: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var backgroundWords: UIImageView!
    
    
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var buttonSkip: UIButton!
    
    var arrayWords:[WordStruct] = []
    var arrayTeams:[TeamStruct] = []
    
    var curTeamIndex = 0
    
    var curLvl = 0
    var curState: gameState!
    var curTime: Float = 0
    
    var maxCountWord = 0
    let maxCountSkip = 5
    var curIndexWord = 0
    
    let timeStep: Float = 0.01
    let shapeLayer = CAShapeLayer()
    var countFired: CGFloat = 0
    var timer: Timer? = Timer()
    
    var backgroundTimer: CAShapeLayer = CAShapeLayer()
    var foregroundLayer: CAShapeLayer = CAShapeLayer()
    
    var myLabel: UILabel = UILabel()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
           if #available(iOS 13.0, *) {
               return .darkContent
           } else {
               return .default
           }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let sound = Bundle.main.path(forResource: "sound_button_ok", ofType: "wav")
        let sound2 = Bundle.main.path(forResource: "tick", ofType: "wav")
        let sound3 = Bundle.main.path(forResource: "Blop", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            
        } catch {
            print("error music1")
        }
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
            
        } catch {
            print("error music2")
        }
        
        do {
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
            audioPlayer3.setVolume(0.35, fadeDuration: .zero)
        } catch {
            print("error music3")
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        alert.delegate = self
        
        buttonOk.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonOk.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpInside, .touchCancel])
        
        buttonSkip.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonSkip.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpInside, .touchCancel])
        
        
        let point = UIScreen.main.bounds.width * UIScreen.main.bounds.height * 168 / 421 / 336
        
        let j = UIBezierPath(arcCenter: CGPoint.init(x: view.center.x, y: view.center.y - (point / 4) - 50), radius: 30, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        backgroundTimer.path = j.cgPath
        backgroundTimer.strokeColor = UIColor.lightGray.cgColor
        backgroundTimer.fillColor = UIColor.clear.cgColor
        backgroundTimer.lineWidth = 3
        backgroundTimer.strokeEnd = 1
        
        
        foregroundLayer.path = UIBezierPath(arcCenter: CGPoint.init(x: view.center.x, y: view.center.y - (point / 4) - 50), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 3 / 2, clockwise: true).cgPath
        
        foregroundLayer.strokeColor = #colorLiteral(red: 1, green: 0.3844202161, blue: 0.2805069387, alpha: 1)
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = 5
        foregroundLayer.strokeEnd = 0
        
        foregroundLayer.lineCap = .round
        
        myLabel = UILabel(frame: CGRect.init(x: j.currentPoint.x - 50, y: j.currentPoint.y - 10, width: 40, height: 20))
        myLabel.textAlignment = .center
        myLabel.text = "0"
        myLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 22)
        myLabel.textColor = UIColor.black
        
       
        
        updateLabels()
        
        
        view.layer.addSublayer(backgroundTimer)
        view.layer.addSublayer(foregroundLayer)
        view.addSubview(myLabel)
        
        setupVisualEffectView()
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeStep), target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
        
       
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
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
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
    
    
    @objc func checkTime() {
        //curTime = min(timeStep + curTime, Float(60))
        foregroundLayer.strokeEnd += 0.000165
        check += 1
        if check % 100 == 0 {
            temp += 1
            myLabel.text = "\(temp)"
        }
        if  temp >= 60 {
            foregroundLayer.strokeEnd = 1
            timer?.invalidate()
            timer = nil
            goToPreGameVC(curState: .nextTeam)
        } else if temp >= 55 {
            audioPlayer2.play()
        }
    }
    
    
    private func updateLabels() {
        
        labelWord.text = arrayWords[curIndexWord].word
        labelPoint.text =  "+\(arrayWords[curIndexWord].points)"
        labelWordsOk.text = "\(curIndexWord)/\(maxCountWord)"
        labelWordsSkip.text = "\(arrayTeams[curTeamIndex].skipNumber)/\(maxCountSkip)"
       
    }
    
    
    private func sendDataToPreGameVC(preGameVC: PreGameViewController, curIndexWord: Int, curState: gameState) {
        preGameVC.arrayTeams = arrayTeams
        preGameVC.arrayWords = arrayWords
        preGameVC.curTeamIndex = curTeamIndex
        preGameVC.maxCountWord = maxCountWord
        preGameVC.curIndexWord = curIndexWord
        preGameVC.curLvl = curLvl
        preGameVC.curState = curState
    }
    
    
    func getWinner() -> TeamStruct {
        var bestTeam = arrayTeams[0]
        var maxPoints = arrayTeams[0].pointsNumber
        
        for i in 1..<arrayTeams.count {
            if (arrayTeams[i].pointsNumber > maxPoints) {
                maxPoints = arrayTeams[i].pointsNumber
                bestTeam = arrayTeams[i]
            }
        }
        
        return bestTeam
    }
    
    
    private func goToPreGameVC(curState: gameState!) {
        if curLvl == 2 && curState! == .nextRound {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let preGameVC = storyBoard.instantiateViewController(withIdentifier: "vc222") as! WinnerViewController
            preGameVC.modalPresentationStyle = .currentContext
            let winner = getWinner()
            preGameVC.winnerTeam = winner
            preGameVC.arrayTeams = arrayTeams
            self.present(preGameVC, animated: true, completion: nil)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let preGameVC = storyBoard.instantiateViewController(withIdentifier: "vc") as! PreGameViewController
            preGameVC.modalPresentationStyle = .currentContext
            sendDataToPreGameVC(preGameVC: preGameVC, curIndexWord: curIndexWord, curState: curState)
            self.present(preGameVC, animated: true, completion: nil)
        }
    }

    
    @IBAction func getNextWord(_ sender: UIButton) {
        
        audioPlayer.play()
        curIndexWord += 1
        arrayTeams[curTeamIndex].pointsNumber += arrayWords[curIndexWord - 1].points
        collectionView.reloadData()
       
        if (curIndexWord >= maxCountWord) { goToPreGameVC(curState: .nextRound) } else { updateLabels() }
        
        
    }
    
    
    @IBAction func getNextSkip(_ sender: Any) {
        if (arrayTeams[curTeamIndex].skipNumber < maxCountSkip) {
            audioPlayer3.play()
            if (curIndexWord < maxCountWord) {
                for i in curIndexWord..<(maxCountWord - 1) {
                    arrayWords[i] = arrayWords[i + 1]
                }
                arrayWords.removeLast()
                
                maxCountWord -= 1
                arrayTeams[curTeamIndex].skipNumber += 1
                updateLabels()
            }
            
            if (curIndexWord == maxCountWord) {
                print("else -> \(curIndexWord) / \(maxCountWord)")
                goToPreGameVC(curState: .nextRound)
            }
        }
    }
    
    
    @IBAction func backMainMenu(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        setAlert()
        animateIn()
    }
}


extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    AlertBackDelegate {
    
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
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeStep), target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTeams.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCollectionViewCell {
            itemCell.team = arrayTeams[indexPath.row]
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
