//
//  CreatePollViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 28/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import Pastel

var pollQDetails = ["id" : "", "question" : ""]
var choice1Details = ["value": "", "votes" : 42, "pollId" : "", "externalId": ""] as [String : Any]
var choice2Details = ["value": "", "votes" : 42, "pollId" : "", "externalId": ""] as [String : Any]
var choice3Details = ["value": "", "votes" : 42, "pollId" : "", "externalId": ""] as [String : Any]
var choice4Details = ["value": "", "votes" : 42, "pollId": "", "externalId": ""] as [String : Any]

class CreatePollViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var characterLabel: UILabel!
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        characterLabel.text = String(35 - (textView.text.count + (text.count - range.length)))
        return textView.text.count + (text.count - range.length) <= 35
    }
    
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var shadowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.delegate = self
        impactFeedbackgenerator.prepare()
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))

        self.navigationController?.isNavigationBarHidden = false
 
        let newButton = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height/2 + 10)), width: (self.view.frame.width/1.25), height: 45))
        newButton.center.x = self.view.center.x
        newButton.startPastelPoint = .bottomLeft
        newButton.endPastelPoint = .topRight
        newButton.animationDuration = 0.5
        newButton.startAnimation()
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextClicked)))
        //        newButton.setColors([UIColor(red: 8/255, green: 41/255, blue: 224/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 91/255, blue: 163/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 72/255, blue: 163/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 121/255, blue: 163/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 155/255, blue: 163/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 54/255, blue: 163/255, alpha: 1.0),
        //                             UIColor(red: 8/255, green: 142/255, blue: 163/255, alpha: 1.0)])
        newButton.setPastelGradient(.ariellesSmile)
        //        newButton.layer.cornerRadius = 8.0
        //        newButton.clipsToBounds = true
        //        newButton.layer.masksToBounds = false
        newButton.layer.shadowColor = UIColor.darkGray.cgColor
        newButton.layer.shadowOpacity = 1
        newButton.layer.shadowOffset = .zero
        newButton.layer.shadowRadius = 5
        newButton.layer.shadowPath = UIBezierPath(rect: newButton.bounds).cgPath
        
        let text = UILabel(frame: CGRect(x: (newButton.frame.width/2) - (newButton.frame.width/3) , y: (newButton.frame.height/2) - (newButton.frame.height/3) + 7 , width: newButton.frame.width/1.5, height: 15))
        text.textAlignment = .center
        //text.center.x = newButton.center.x
        
        
        
        text.text = "Continue"
        text.textColor = .white
        
        newButton.addSubview(text)
        view.insertSubview(newButton, at: 0)
        
        
    }
    
    @objc func nextClicked() {
        impactFeedbackgenerator.impactOccurred()
        if questionTextView.text.isEmpty {
            
            
        } else {
        pollQDetails["question"] = questionTextView.text
            performSegue(withIdentifier: "optionSegue", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        questionTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        shadowView.layer.cornerRadius = 12.0
        let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius)
        shadowView.clipsToBounds = true
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowPath = shadowPath.cgPath
        
       
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
