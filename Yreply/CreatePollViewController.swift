//
//  CreatePollViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 28/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit

class CreatePollViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var shadowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
        shadowView.layer.cornerRadius = 12.0
        let shadowPath = UIBezierPath(rect: view.bounds)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowPath = shadowPath.cgPath
        questionTextView.becomeFirstResponder()
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
