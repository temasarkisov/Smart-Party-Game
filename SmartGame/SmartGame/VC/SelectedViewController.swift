//
//  SelectedViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 11/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

class SelectedViewController: UIViewController {
    
    var topicCollectionView = TopicCollectionView()
    
    private lazy var alert: AlertView = {
        let alertView: AlertView = AlertView.loadFromNib()
        alertView.deligate = self
        return alertView
    }()
    
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBOutlet weak var labelTeam: UILabel!
    
    var arrayTopic: [TopicStruct] =
        [
            TopicStruct(curNameTopic: "Микс", curNameFile: "topic_mix", curNameImage: "mix", curIsPurchased: true),
            TopicStruct(curNameTopic: "География", curNameFile: "topic_geography", curNameImage: "geo", curIsPurchased: true),
            TopicStruct(curNameTopic: "Еда", curNameFile: "topic_food", curNameImage: "food", curIsPurchased: true),
            TopicStruct(curNameTopic: "История", curNameFile: "topic_history", curNameImage: "history", curIsPurchased: true),
            TopicStruct(curNameTopic: "Технологии", curNameFile: "topic_technologys", curNameImage: "invention", curIsPurchased: true),
            TopicStruct(curNameTopic: "Искусство", curNameFile: "topic_arts", curNameImage: "arts", curIsPurchased: true),
            TopicStruct(curNameTopic: "Психология", curNameFile: "topic_human", curNameImage: "psycho", curIsPurchased: true),
            TopicStruct(curNameTopic: "Спорт", curNameFile: "topic_sport", curNameImage: "sport", curIsPurchased: true),
            TopicStruct(curNameTopic: "Физ-мат", curNameFile: "topic_phisicsmaths", curNameImage: "fismath", curIsPurchased: true),
            TopicStruct(curNameTopic: "Фильмы", curNameFile: "topic_films", curNameImage: "cinema", curIsPurchased: true),
            TopicStruct(curNameTopic: "Книги", curNameFile: "topic_books", curNameImage: "books", curIsPurchased: true),
            TopicStruct(curNameTopic: "Профессии", curNameFile: "topic_jobs", curNameImage: "prof", curIsPurchased: true),
            TopicStruct(curNameTopic: "Вечеринка", curNameFile: "topic_party", curNameImage: "party", curIsPurchased: true),
            TopicStruct(curNameTopic: "Одежда", curNameFile: "topic_clothing", curNameImage: "wear", curIsPurchased: true),
            TopicStruct(curNameTopic: "Умные дети", curNameFile: "topic_kids", curNameImage: "kids", curIsPurchased: true),
            TopicStruct(curNameTopic: "Путешествия", curNameFile: "topic_cities", curNameImage: "travel", curIsPurchased: true),
            TopicStruct(curNameTopic: "Биология", curNameFile: "topic_bio", curNameImage: "bio", curIsPurchased: true),
            TopicStruct(curNameTopic: "Военная тема", curNameFile: "topic_military", curNameImage: "military", curIsPurchased: true)
    ]
    
    var arrayButton: [UIButton] = []
    
    @IBOutlet weak var buttonTeam1: UIButton!
    @IBOutlet weak var buttonTeam2: UIButton!
    @IBOutlet weak var buttonTeam3: UIButton!
    @IBOutlet weak var buttonTeam4: UIButton!
    @IBOutlet weak var buttonTeam5: UIButton!
    
    @IBOutlet weak var buttonEasyLvl: UIButton!
    @IBOutlet weak var buttonHardLvl: UIButton!
    @IBOutlet weak var buttonAllLvl: UIButton!
    
    @IBOutlet weak var buttonPlay: UIButton!
    
    var checkActiveTeams: [Bool] = [false, false, false, false, false]
    
    var checkActiveLvl: [Bool] = [false, false, false]
    
    func getArrayWords(countTeams: Int, level: LevelType) -> [WordStruct] {
        var finalArray: [WordStruct] = []
        var countOneTopicWords: Int = 0
        var countWords = 0
        
        if topicCollectionView.indexTopic.count == 0 {
            print("no topics")
            return []
        }
        
        if countTeams != 0 {
            print("teams count \(topicCollectionView.indexTopic.count)")
            if countTeams == 1 {
                countWords = 50
            } else if countTeams == 2 {
                countWords = 50
            } else if countTeams == 3 {
                countWords = 70
            } else if countTeams == 4 {
                countWords = 90
            } else if countTeams == 5 {
                countWords = 100
            }
            countOneTopicWords = countWords / topicCollectionView.indexTopic.count
            
            for el in topicCollectionView.indexTopic {
                print("на обработке топик \(arrayTopic[el].nameFile)")
            }
            
            if topicCollectionView.indexTopic.count != 1  {
                for i in 0..<topicCollectionView.indexTopic.count - 1 {
                    finalArray += topicParser(fileName: topicCollectionView.arrayTopic[topicCollectionView.indexTopic[i]].nameFile, level: level, countWords: countOneTopicWords)
                }
                finalArray += topicParser(fileName: topicCollectionView.arrayTopic[topicCollectionView.indexTopic.last!].nameFile, level: level, countWords: (countWords - (countOneTopicWords * (topicCollectionView.indexTopic.count - 1))))
            } else {
                finalArray += topicParser(fileName: topicCollectionView.arrayTopic[topicCollectionView.indexTopic.last!].nameFile, level: level, countWords: countWords)
            }
            return finalArray
        }
        return finalArray
    }
    
    
    func getArrayTeams(arrayActiveTeams: [Bool]) -> [TeamStruct] {
        var finalArrayTeams: [TeamStruct] = []
        for i in 0..<arrayActiveTeams.count {
            if arrayActiveTeams[i] {
                var tempTeam = TeamStruct()
                tempTeam.imageName = "\(i + 1)" + "pers"
                tempTeam.pointsNumber = 0
                tempTeam.teamIndicator = i + 1
                finalArrayTeams.append(tempTeam)
            }
        }
        return finalArrayTeams
    }
    
    
    func getLevel(arrayActiveLevels: [Bool]) -> LevelType? {
        var lvl: LevelType? = nil
        
        for i in 0..<arrayActiveLevels.count {
            if arrayActiveLevels[i] {
                switch i {
                case 0: lvl = .easy; break
                case 1: lvl = .hard; break
                case 2: lvl = .all; break
                default: break
                }
                break
            }
        }
        
        return lvl
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(topicCollectionView)
        
        buttonTeam1.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonTeam1.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonTeam2.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonTeam2.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonTeam3.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonTeam3.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonTeam4.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonTeam4.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonTeam5.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonTeam5.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonEasyLvl.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonEasyLvl.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonHardLvl.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonHardLvl.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonAllLvl.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonAllLvl.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        buttonPlay.addTarget(self, action: #selector(animationIn(sender:)), for: [.touchDown])
        buttonPlay.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside])
        
        topicCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        topicCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topicCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topicCollectionView.heightAnchor.constraint(equalTo: topicCollectionView.widthAnchor, multiplier: 271/414).isActive = true
        topicCollectionView.set(cells: arrayTopic)
        
        setupVisualEffectView()
        
        labelTeam.bottomAnchor.constraint(equalTo: topicCollectionView.topAnchor, constant: -10).isActive = true
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           if #available(iOS 13.0, *) {
               return .darkContent
           } else {
               return .default
           }
    }
    
    
    @IBAction func toSelectTeam1(_ sender: Any) {
        switch checkActiveTeams[0] {
            case false:
                checkActiveTeams[0] = true
                buttonTeam1.setImage(UIImage(named: "1persActive"), for: .normal)
                break
            case true:
                checkActiveTeams[0] = false
                buttonTeam1.setImage(UIImage(named: "1pers"), for: .normal)
        }
    }
    
    
    @IBAction func toSelectTeam2(_ sender: Any) {
        switch checkActiveTeams[1] {
            case false:
                checkActiveTeams[1] = true
                buttonTeam2.setImage(UIImage(named: "2persActive"), for: .normal)
                break
            case true:
                checkActiveTeams[1] = false
                buttonTeam2.setImage(UIImage(named: "2pers"), for: .normal)
        }
    }
    
    
    @IBAction func toSelectTeam3(_ sender: Any) {
        switch checkActiveTeams[2] {
            case false:
                checkActiveTeams[2] = true
                buttonTeam3.setImage(UIImage(named: "3persActive"), for: .normal)
                break
            case true:
                checkActiveTeams[2] = false
                buttonTeam3.setImage(UIImage(named: "3pers"), for: .normal)
        }
    }
    
    
    @IBAction func toSelectTeam4(_ sender: Any) {
        switch checkActiveTeams[3] {
        case false:
            checkActiveTeams[3] = true
            buttonTeam4.setImage(UIImage(named: "4persActive"), for: .normal)
            break
        case true:
            checkActiveTeams[3] = false
            buttonTeam4.setImage(UIImage(named: "4pers"), for: .normal)
        }
    }
    
    
    @IBAction func toSelectTeam5(_ sender: Any) {
        switch checkActiveTeams[4] {
        case false:
            checkActiveTeams[4] = true
            buttonTeam5.setImage(UIImage(named: "5persActive"), for: .normal)
            break
        case true:
            checkActiveTeams[4] = false
            buttonTeam5.setImage(UIImage(named: "5pers"), for: .normal)
        }
    }
    
    
    @IBAction func backMainMenu(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenuVC = storyBoard.instantiateViewController(withIdentifier: "mainMenu") as! MainMenuViewController
        mainMenuVC.modalPresentationStyle = .currentContext
        self.present(mainMenuVC, animated: true, completion: nil)
    }
    
    
    @IBAction func selectEasyLvl(_ sender: Any) {
        checkActiveLvl[1] = false; checkActiveLvl[2] = false
        buttonHardLvl.setImage(UIImage(named: "hard_lvl"), for: .normal)
        buttonAllLvl.setImage(UIImage(named: "all_lvl"), for: .normal)
        if checkActiveLvl[0] == true {
            buttonEasyLvl.setImage(UIImage(named: "easy_lvl"), for: .normal)
            checkActiveLvl[0] = false
        } else {
            buttonEasyLvl.setImage(UIImage(named: "easy_lvl_active"), for: .normal)
            checkActiveLvl[0] = true
        }
    }
    
    
    @IBAction func selectHardLvl(_ sender: Any) {
        checkActiveLvl[0] = false; checkActiveLvl[2] = false
        buttonAllLvl.setImage(UIImage(named: "all_lvl"), for: .normal)
        buttonEasyLvl.setImage(UIImage(named: "easy_lvl"), for: .normal)
        if checkActiveLvl[1] == true {
            buttonHardLvl.setImage(UIImage(named: "hard_lvl"), for: .normal)
            checkActiveLvl[1] = false
        } else {
            buttonHardLvl.setImage(UIImage(named: "hard_lvl_active"), for: .normal)
            checkActiveLvl[1] = true
        }
    }
    
    
    @IBAction func selectAllLvl(_ sender: Any) {
        checkActiveLvl[0] = false
        checkActiveLvl[1] = false
        buttonHardLvl.setImage(UIImage(named: "hard_lvl"), for: .normal)
        buttonEasyLvl.setImage(UIImage(named: "easy_lvl"), for: .normal)
        if checkActiveLvl[2] == true
        {
            buttonAllLvl.setImage(UIImage(named: "all_lvl"), for: .normal)
            checkActiveLvl[2] = false
        }
        else
        {
            buttonAllLvl.setImage(UIImage(named: "all_lvl_active"), for: .normal)
            checkActiveLvl[2] = true
        }
    }
    
    
    @IBAction func startGame(_ sender: Any)
        {
            let curLvl = getLevel(arrayActiveLevels: checkActiveLvl)
            let arrayTeams = getArrayTeams(arrayActiveTeams: checkActiveTeams)
            var arrayWords: [WordStruct] = []
            
            
            if ((curLvl ?? LevelType.noLvl ) == LevelType.noLvl || arrayTeams.count < 2) {
                setAlert()
                animateIn()
                return
            } else {
                arrayWords = getArrayWords(countTeams: arrayTeams.count, level: curLvl!)
                if arrayWords.count == 0 {
                    setAlert()
                    animateIn()
                    return
                }
                for _ in 0...5 {
                    arrayWords.shuffle()
                }
            }
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let preGameVC = storyBoard.instantiateViewController(withIdentifier: "vc") as! PreGameViewController
            preGameVC.modalTransitionStyle = .crossDissolve
            preGameVC.modalPresentationStyle = .currentContext
            preGameVC.arrayTeams = arrayTeams
            preGameVC.curTeamIndex = -1
            preGameVC.curState = .nextTeam
            preGameVC.arrayWords = arrayWords
            self.present(preGameVC, animated: true, completion: nil)
            
    }
        
}
    


    


extension SelectedViewController: AlertDelegate {
    func actionButton() {
        animateOut()
    }
}
