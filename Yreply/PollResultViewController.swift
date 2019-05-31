//
//  PollResultViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 31/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit

class PollResultViewController: UIViewController {
    
    var resultLoad: NSDictionary!
    @IBOutlet weak var answerOneLabel: UILabel!
    @IBOutlet weak var answerOneVotes: UILabel!
    @IBOutlet weak var answerTwoLabel: UILabel!
    @IBOutlet weak var answerTwoVotes: UILabel!
    @IBOutlet weak var answerThreeView: GradientView!
    @IBOutlet weak var answerThreeLabel: UILabel!
    @IBOutlet weak var answerThreeVotes: UILabel!
    @IBOutlet weak var answerFourView: GradientView!
    @IBOutlet weak var answerFourLabel: UILabel!
    @IBOutlet weak var answerFourVotes: UILabel!
    @IBOutlet weak var questionResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionResultLabel.text = resultLoad["question"] as? String
        let choices = resultLoad?["choices"] as? NSArray
        
        if choices?.count == 2 {
            answerThreeView.isHidden = true
            answerFourView.isHidden = true
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            
            answerOneLabel.text = innerVal1?["value"] as? String
            answerOneVotes.text = String(innerVal1?["votes"] as! Int) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(innerVal2?["votes"] as! Int) + "\t votes"
            
            
            
        }
        else if choices?.count == 3 {
            answerFourView.isHidden = true
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            let innerVal3 = choices?[2] as? NSDictionary
            
            answerOneLabel.text = innerVal1?["value"] as? String
            answerOneVotes.text = String(innerVal1?["votes"] as! Int) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(innerVal2?["votes"] as! Int) + "\t votes"
            answerThreeLabel.text = innerVal3?["value"] as? String
            answerThreeVotes.text = String(innerVal3?["votes"] as! Int) + "\t votes"
            
            
        }
        else if choices?.count == 4 {
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            let innerVal3 = choices?[2] as? NSDictionary
            let innerVal4 = choices?[3] as? NSDictionary
            
            answerOneLabel.text = innerVal1?["value"] as? String
            answerOneVotes.text = String(innerVal1?["votes"] as! Int) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(innerVal2?["votes"] as! Int) + "\t votes"
            answerThreeLabel.text = innerVal3?["value"] as? String
            answerThreeVotes.text = String(innerVal3?["votes"] as! Int) + "\t votes"
            answerFourLabel.text = innerVal4?["value"] as? String
            answerFourVotes.text = String(innerVal4?["votes"] as! Int) + "\t votes"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
