//
//  OptionsViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 28/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import Pastel
import Firebase

class OptionsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var optionOne: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var optionTwo: UITextField!
    @IBOutlet weak var optionThree: UITextField!
    @IBOutlet weak var optionFour: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        ref = Database.database().reference()
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: optionTwo.frame.size.height - width, width:  optionTwo.frame.size.width + 16, height: optionTwo.frame.size.height)
        border.borderWidth = width
        optionTwo.layer.addSublayer(border)
        optionTwo.layer.masksToBounds = true
        
        let border1 = CALayer()
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor.lightGray.cgColor
        border1.frame = CGRect(x: 0, y: optionOne.frame.size.height - width1, width:  optionOne.frame.size.width + 16, height: optionOne.frame.size.height)
        border1.borderWidth = width1
        optionOne.layer.addSublayer(border1)
        optionOne.layer.masksToBounds = true
        
        let border2 = CALayer()
        let width2 = CGFloat(1.0)
        border2.borderColor = UIColor.lightGray.cgColor
        border2.frame = CGRect(x: 0, y: optionThree.frame.size.height - width2, width:  optionThree.frame.size.width + 16, height: optionThree.frame.size.height)
        border2.borderWidth = width2
        optionThree.layer.addSublayer(border2)
        optionThree.layer.masksToBounds = true
        
        
        let newButton = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height/2)), width: (self.view.frame.width/1.25), height: 45))
        newButton.center.x = self.view.center.x
        newButton.startPastelPoint = .bottomLeft
        newButton.endPastelPoint = .topRight
        newButton.animationDuration = 0.5
        newButton.startAnimation()
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(continueClicked)))
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
        
        // Do any additional setup after loading the view.
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @objc func continueClicked() {
        if optionOne.text?.isEmpty == true || optionTwo.text?.isEmpty == true {
            if optionOne.text?.isEmpty == true{
                optionOne.placeholder = "Please fill in this field"
            }
            else if optionTwo.text?.isEmpty == true {
                optionTwo.placeholder = "Please fill in this field"
            }
        } else {
            let randStr = randomString(length: 10)
            pollQDetails["id"] = randStr
          
            choice1Details["value"] = optionOne.text!
            choice1Details["votes"] = 0
            choice1Details["pollId"] = randStr
            choice1Details["externalId"] = extImp
            
            choice2Details["value"] = optionTwo.text!
            choice2Details["votes"] = 0
            choice2Details["pollId"] = randStr
            choice2Details["externalId"] = extImp

            
            
            if optionThree.text?.isEmpty == false {
                choice3Details["value"] = optionThree.text!
                choice3Details["votes"] = 0
                choice3Details["pollId"] = randStr
                choice3Details["externalId"] = extImp

            }
            
            if optionFour.text?.isEmpty == false {
                choice4Details["value"] = optionFour.text!
                choice4Details["votes"] = 0
                choice4Details["pollId"] = randStr
                choice4Details["externalId"] = extImp

            }
            
          
            
            self.ref.child("polls").child(extImp).child("\(pollQDetails["id"]!)").setValue(["question": pollQDetails["question"]])
            self.ref.child("polls").child(extImp).child("\(pollQDetails["id"]!)").child("choices").child("0").setValue(["value": choice1Details["value"], "votes" : choice1Details["votes"], "pollId" : choice1Details["pollId"], "externalId" : choice1Details["externalId"]])
                self.ref.child("polls").child(extImp).child("\(pollQDetails["id"]!)").child("choices").child("1").setValue(["value": choice2Details["value"], "votes" : choice2Details["votes"], "pollId" : choice2Details["pollId"], "externalId" : choice2Details["externalId"]])
            
                    self.ref.child("polls").child(extImp).child("\(pollQDetails["id"]!)").child("choices").child("2").setValue(["value": choice3Details["value"], "votes" : choice3Details["votes"], "pollId" : choice3Details["pollId"], "externalId" : choice3Details["externalId"]])
                        self.ref.child("polls").child(extImp).child("\(pollQDetails["id"]!)").child("choices").child("3").setValue(["value": choice4Details["value"], "votes" : choice4Details["votes"], "pollId" : choice4Details["pollId"], "externalId" : choice4Details["externalId"]])
            performSegue(withIdentifier: "finalPollSegue", sender: self)
        }
        
    }
    
    @IBAction func WroteInSecondTextField(_ sender: Any) {
        optionThree.isHidden = false
    }
    
    @IBAction func wroteInThirdTextField(_ sender: Any) {
        optionFour.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == optionOne {
            textField.resignFirstResponder()
            optionTwo.becomeFirstResponder()
        } else if textField == optionTwo && optionThree.isHidden == false {
            textField.resignFirstResponder()
            optionThree.becomeFirstResponder()
        } else if textField == optionThree && optionFour.isHidden == false {
            textField.resignFirstResponder()
            optionFour.becomeFirstResponder()
        } else if textField == optionFour {
            textField.resignFirstResponder()
        }
        return true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        optionOne.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        textFieldView.layer.cornerRadius = 12.0
        let shadowPath = UIBezierPath(roundedRect: textFieldView.bounds, cornerRadius: textFieldView.layer.cornerRadius)
        textFieldView.clipsToBounds = true
        textFieldView.layer.masksToBounds = false
        textFieldView.layer.shadowColor = UIColor.darkGray.cgColor
        textFieldView.layer.shadowOffset = .zero
        textFieldView.layer.shadowOpacity = 1
        textFieldView.layer.shadowPath = shadowPath.cgPath
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
