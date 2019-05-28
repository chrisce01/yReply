//
//  MainScreenViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 27/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import SCSDKBitmojiKit
import SCSDKLoginKit
import Pastel

var nameAndBitmojiArray: Array<String>!

class MainScreenViewController: UIViewController {
    
    
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = true
       
        
        
        impactFeedbackgenerator.prepare()
        let iconView = SCSDKBitmojiIconView()
        if let isArray = nameAndBitmojiArray {
            print(isArray)
        }
    iconView.frame = CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3) - 50, y: 50, width: 55, height: 55)
    iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bitmojiClicked)))
    view.addSubview(iconView)
    
        let newButton = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height/2)+200), width: (self.view.frame.width/1.25), height: 45))
        newButton.center.x = self.view.center.x
        newButton.startPastelPoint = .bottomLeft
        newButton.endPastelPoint = .topRight
        newButton.animationDuration = 0.5
        newButton.startAnimation()
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonClicked)))
        newButton.setColors([UIColor(red: 8/255, green: 41/255, blue: 224/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 91/255, blue: 163/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 72/255, blue: 163/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 121/255, blue: 163/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 155/255, blue: 163/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 54/255, blue: 163/255, alpha: 1.0),
                             UIColor(red: 8/255, green: 142/255, blue: 163/255, alpha: 1.0)])
        //        newButton.layer.cornerRadius = 8.0
        //        newButton.clipsToBounds = true
        //        newButton.layer.masksToBounds = false
        newButton.layer.shadowColor = UIColor.darkGray.cgColor
        newButton.layer.shadowOpacity = 1
        newButton.layer.shadowOffset = .zero
        newButton.layer.shadowRadius = 5
        newButton.layer.shadowPath = UIBezierPath(rect: newButton.bounds).cgPath
        
        let text = UILabel(frame: CGRect(x: (newButton.frame.width/2) - (newButton.frame.width/3) , y: (newButton.frame.height/2) - (newButton.frame.height/3) + 7 , width: newButton.frame.width/1.5, height: 15))
        text.center.x = newButton.center.x
        
        
        
        text.text = "Create New Poll"
        text.textColor = .white
        
        newButton.addSubview(text)
        view.insertSubview(newButton, at: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
       
    }
    
    @objc func buttonClicked() {
        impactFeedbackgenerator.impactOccurred()
        
        self.performSegue(withIdentifier: "createPollSegue", sender: self)
    }
    
    
    @objc func bitmojiClicked() {
        impactFeedbackgenerator.impactOccurred()
        let alert = UIAlertController(title: nameAndBitmojiArray[0], message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Contact Us", style: .default , handler:{ (UIAlertAction)in
        }))
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive , handler:{ (UIAlertAction)in
            SCSDKLoginClient.unlinkCurrentSession { (success: Bool) in
                if success == true {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler:{ (UIAlertAction)in
        }))
        
        self.present(alert, animated: true, completion: nil)
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
