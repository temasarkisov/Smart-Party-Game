//
//  RuleViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 16/02/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import UIKit

@IBDesignable
class RuleViewController: UIViewController {
    
    
    @IBOutlet weak var ruleTextView: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let string = ruleTextView.text
        
        let color = #colorLiteral(red: 0.9960784314, green: 0.3882352941, blue: 0.3058823529, alpha: 1)
        
        
        let attributedString = NSMutableAttributedString(string: string!)
        
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        let spacing = NSMutableParagraphStyle()
        
        spacing.lineSpacing = 5
        
        let attributes1 = [NSAttributedString.Key.paragraphStyle: spacing]
        
        attributedString.addAttributes(attributes1, range: NSRange(location: 0, length: ruleTextView.text.count - 30))
        
        attributedString.addAttributes(attributes, range: NSRange(location: 24, length: 6))
        attributedString.addAttributes(attributes, range: NSRange(location: 274, length: 3))
        
        ruleTextView.attributedText = attributedString
        
        ruleTextView.backgroundColor = UIColor.clear
        
        ruleTextView.textAlignment = .center
        
        ruleTextView.font = UIFont(name: "LucidaGrande-Bold", size: 18)
        
        
        

    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    
    @IBAction func backButton(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenuVC = storyBoard.instantiateViewController(withIdentifier: "mainMenu") as! MainMenuViewController
        mainMenuVC.modalPresentationStyle = .currentContext
        self.present(mainMenuVC, animated: true, completion: nil)
    }
    
}
