//
//  PollResultViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 31/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit

class PollResultViewController: UIViewController {
    
    var resultLoad: Polls!
    @IBOutlet weak var answerOneView: GradientView!
    @IBOutlet weak var answerOneLabel: UILabel!
    @IBOutlet weak var answerOneVotes: UILabel!
    @IBOutlet weak var answerTwoView: GradientView!
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
        questionResultLabel.text = resultLoad.question as? String
        let choices = resultLoad.choices as? NSArray
        
        if choices?.count == 2 {
            answerThreeView.isHidden = true
            answerFourView.isHidden = true
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            
            answerOneLabel.text = innerVal1?["value"] as? String
            let vote1 = innerVal1?["votes"] as! Int
            let vote2 = innerVal2?["votes"] as! Int
            answerOneVotes.text = String(vote1) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(vote2) + "\t votes"
            var totalVotes = vote1 + vote2
            if totalVotes == 0 {
                totalVotes = 1
            }
            if vote1>=vote2{
                answerOneView.topColor = UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
            } else if vote2 >= vote1 {
                answerTwoView.topColor =  UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerOneView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                
            }
            
            
        }
        else if choices?.count == 3 {
            answerFourView.isHidden = true
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            let innerVal3 = choices?[2] as? NSDictionary
            
            let vote1 = innerVal1?["votes"] as! Int
            let vote2 = innerVal2?["votes"] as! Int
            let vote3 = innerVal3?["votes"] as! Int
            var totalVotes = vote1 + vote2 + vote3
            if totalVotes == 0 {
                totalVotes = 1
            }
            let arrayOfVotes = [vote1, vote2, vote3]
            let maxv = arrayOfVotes.max() ?? 0
            let index = arrayOfVotes.firstIndex(of: maxv)
            if index == 0{
                answerOneView.topColor =  UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerThreeView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
            } else if index == 1{
                answerOneView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerThreeView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
                
            } else if index == 2 {
                answerOneView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerThreeView.topColor =  UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
            }
            
            answerOneLabel.text = innerVal1?["value"] as? String
            answerOneVotes.text = String(vote1) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(vote2) + "\t votes"
            answerThreeLabel.text = innerVal3?["value"] as? String
            answerThreeVotes.text = String(vote3) + "\t votes"
            
            
        }
        else if choices?.count == 4 {
            let innerVal1 = choices?[0] as? NSDictionary
            let innerVal2 = choices?[1] as? NSDictionary
            let innerVal3 = choices?[2] as? NSDictionary
            let innerVal4 = choices?[3] as? NSDictionary
         
            
            let vote1 = innerVal1?["votes"] as! Int
            let vote2 = innerVal2?["votes"] as! Int
            let vote3 = innerVal3?["votes"] as! Int
            let vote4 = innerVal4?["votes"] as! Int
            
            var totalVotes = vote1 + vote2 + vote3 + vote4
            if totalVotes == 0 {
                totalVotes = 1
            }
            let arrayOfVotes = [vote1, vote2, vote3, vote4]
            let maxv = arrayOfVotes.max() ?? 0
            let index = arrayOfVotes.firstIndex(of: maxv)
            
            if index == 0{
                answerOneView.topColor = UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerThreeView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerFourView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
                answerFourView.endPointX = CGFloat((CGFloat(vote4)/CGFloat(totalVotes)) * 1.3)
            } else if index == 1 {

                answerOneView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerThreeView.topColor =   UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerFourView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
                answerFourView.endPointX = CGFloat((CGFloat(vote4)/CGFloat(totalVotes)) * 1.3)            } else if index == 2 {
                answerOneView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerThreeView.topColor =  UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerFourView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
                answerFourView.endPointX = CGFloat((CGFloat(vote4)/CGFloat(totalVotes)) * 1.3)
            } else if index == 3 {
                print("hahah")
                answerOneView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerTwoView.topColor = UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerThreeView.topColor =  UIColor(red: 252/255.0, green: 255/255.0, blue: 160/255.0, alpha: 1.0)
                answerFourView.topColor =  UIColor(red: 241/255.0, green: 251/255.0, blue:58/255.0, alpha: 1.0)
                answerOneView.endPointX = CGFloat((CGFloat(vote1)/CGFloat(totalVotes)) * 1.3)
                answerTwoView.endPointX = CGFloat((CGFloat(vote2)/CGFloat(totalVotes)) * 1.3)
                answerThreeView.endPointX = CGFloat((CGFloat(vote3)/CGFloat(totalVotes)) * 1.3)
                answerFourView.endPointX = CGFloat((CGFloat(vote4)/CGFloat(totalVotes)) * 1.3)
            }
            
            answerOneLabel.text = innerVal1?["value"] as? String
            answerOneVotes.text = String(vote1) + "\t votes"
            answerTwoLabel.text = innerVal2?["value"] as? String
            answerTwoVotes.text = String(vote2) + "\t votes"
            answerThreeLabel.text = innerVal3?["value"] as? String
            answerThreeVotes.text = String(vote3) + "\t votes"
            answerFourLabel.text = innerVal4?["value"] as? String
            answerFourVotes.text = String(vote4) + "\t votes"
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
