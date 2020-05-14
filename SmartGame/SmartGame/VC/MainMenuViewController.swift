//
//  MainMenuViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 04/11/2019.
//  Copyright © 2019 TemaPasha. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController
{
    
    private lazy var alert: AlertViewFirstLaunch = {
        let alertView: AlertViewFirstLaunch = AlertView.loadFromNib()
        alertView.deligate = self
        
        let string = alertView.label.text
        let color = UIColor.black
        let attributedString = NSMutableAttributedString(string: string!)
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 5
        let attributes1 = [NSAttributedString.Key.paragraphStyle: spacing]
        attributedString.addAttributes(attributes1, range: NSRange(location: 0, length: alertView.label.text!.count - 1))
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: alertView.label.text!.count - 1))
        alertView.label.attributedText = attributedString
        alertView.label.textAlignment = .center
        
        return alertView
    }()
    
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonRule: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupVisualEffectView()
        
        //UIApplication.shared.windows.first!.rootViewController = self
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        }
        else {
            print("First launch, setting NSUserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            setAlert()
            animateIn()
        }
        
        
        buttonPlay.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonPlay.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpOutside, .touchCancel])
        
        buttonRule.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonRule.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpInside, .touchCancel])
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
    
    
    @objc fileprivate func animationOut(sender: UIButton)
    {
        UIView.animate(withDuration: 0.3,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }


    @objc fileprivate func animationIn(sender: UIButton)
    {
        UIView.animate(withDuration: 0.2,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if #available(iOS 13.0, *)
        {
            return .darkContent
        }
        else
        {
            return .default
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "5e"
        {
            let preGameVC: SelectedViewController = segue.destination as! SelectedViewController
            preGameVC.modalTransitionStyle = .crossDissolve
            preGameVC.modalPresentationStyle = .currentContext
        }
        else if segue.identifier == "11e"
        {
            let ruleVC: RuleViewController = segue.destination as! RuleViewController
            ruleVC.modalTransitionStyle = .crossDissolve
            ruleVC.modalPresentationStyle = .currentContext
        }
    }
    
    
    
}



extension MainMenuViewController: AlertFirstLaunchDelegate {
    func actionButton() {
        animateOut()
    }
}
