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
import Firebase
import SafariServices
import SwiftOverlays

var nameAndBitmojiArray: Array<String>!

var listOfPolls = [Polls]()


class newCell : UITableViewCell {
    @IBOutlet weak var qLabelLoad: UILabel!
    @IBOutlet weak var voteLabelLoad: UILabel!
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 20
            frame.size.width -= 2 * 20
            super.frame = frame
        }
    }
}

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var refreshControl = UIRefreshControl()

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listOfPolls.count
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poll = listOfPolls[indexPath.section] as? Polls
        self.performSegue(withIdentifier: "pollResultSegue", sender: poll)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pollResultSegue" {
            if let dest = segue.destination as? PollResultViewController{
                if let dets = sender as? Polls{
                    dest.resultLoad = dets
                }
            }
        }
    }
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! newCell
        
        cell.clipsToBounds = true
        cell.layer.masksToBounds = false
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 14
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 1
        
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 2
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.layer.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.layer.bounds, cornerRadius:         cell.layer.cornerRadius).cgPath
        
        
//        let keys = loadPollFromThis.allKeys as! Array<String>
        //let poll = loadPollFromThis[keys[indexPath.section]] as? NSDictionary
//        let poll = loadPollFromThis[indexPath.section] as? NSDictionary
        listOfPolls.sort(by: {$0.timeStamp > $1.timeStamp})
        
        let poll = listOfPolls[indexPath.section]
        
//        print(loadPollFromThis)
//        var new = [Polls]()
//        for arrayIndex in stride(from: listOfPolls.count - 1, through: 0, by: -1) {
//            new.append(listOfPolls[arrayIndex])
//        }
//        listOfPolls = new
//        cell.qLabelLoad.text = poll?["question"] as? String
        let choices = poll.choices as? NSArray
        
        cell.qLabelLoad.text = poll.question
        var totalVotes = 0
        if let c = choices?.count {
            for i in 0...c - 1 {
                let innerVal = choices?[i] as? NSDictionary
                totalVotes += innerVal?["votes"] as! Int
            }
        }
        
        cell.voteLabelLoad.text = "Number of Votes: \(totalVotes)"
       // print("ARRE \(choices?.count)")
        
//        cell.layer.shadowShouldRasterize = true
//        cell.layer.shadowRasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    struct UI {
        static let itemHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 88 : 65
        static let lineSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 28 : 20
        static let xInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        static let topInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 28
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBOutlet weak var tableView: UITableView!
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    fileprivate var itemSize: CGSize {
        let width = UIScreen.main.bounds.width - 2 * UI.xInset
        return CGSize(width: width, height: UI.itemHeight)
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.ref.child("polls").child(extImp).queryOrdered(byChild: "timeStamp").observe(.childAdded, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let randPoll = Polls.init(id: snapshot.key, q: value?["question"] as! String, choices: value?["choices"] as? NSArray ?? [0,1,2], time: value?["timeStamp"] as! Int64)
                var append = true
                
                
                
                if randPoll.choices != [0,1,2] {
                    for i in listOfPolls{
                        if i.pollId == randPoll.pollId {
                            append = false
                            i.choices = randPoll.choices
                            self.tableView.reloadData()
                        }
                        
                    }
                    
                    if append == true{
                        
                        listOfPolls.append(randPoll)
                    }
                }
               
            })
            self.dispatchDelay(delay: 2.0, closure: {
                self.refreshControl.endRefreshing()
            })
            
            self.tableView.reloadData()
        }}
    
    func dispatchDelay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.showWaitOverlay()

        }
        dispatchDelay(delay: 3.0) {
            self.tableView.reloadData()
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        ref = Database.database().reference()
        
       self.navigationController?.isNavigationBarHidden = true
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.bounces = true
        self.tableView.backgroundColor = .white
        self.tableView.contentInset.bottom = UI.itemHeight
        self.tableView.backgroundColor = .clear
        self.tableView.separatorColor = .clear
        
        DispatchQueue.main.async {
            
            
            let graphQLQuery = "{me{displayName, bitmoji{avatar}, externalId}}"
            
            let variables = ["page": "bitmoji"]
            
            //            })
            SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: variables, success: { (resources: [AnyHashable: Any]?) in
                guard let resources = resources,
                    let data = resources["data"] as? [String: Any],
                    let me = data["me"] as? [String: Any] else { return }
                let externalId = me["externalId"] as? String
                let displayName = me["displayName"] as? String
                print(me)
                extImp = "\(externalId!.replacingOccurrences(of: "/", with: ""))"
                var bitmojiAvatarUrl: String?
                
                
                
                if let bitmoji = me["bitmoji"] as? [String: Any] {
                    bitmojiAvatarUrl = bitmoji["avatar"] as? String
                    
                    let allDetails = [displayName, bitmojiAvatarUrl] as? Array<String>
                    nameAndBitmojiArray = allDetails

                    
                    // Essential to remove slashes from external id so that firebase doesn't make child after every slash
                    
                    //                        self.ref.child("users").child(externalId!.replacingOccurrences(of: "/", with: "")).setValue(["displayName" : displayName ?? "Default", "bitmojiId" : bitmojiAvatarUrl ?? "NA"])
                    
                    let url = bitmojiAvatarUrl
                    
                    
                    self.ref.child("polls").child(extImp).queryOrdered(byChild: "timeStamp").observe(.childAdded, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let randPoll = Polls.init(id: snapshot.key, q: value?["question"] as! String, choices: value?["choices"] as? NSArray ?? [0,1,2], time: value?["timeStamp"] as! Int64)
                        var append = true
                        if randPoll.choices != [0,1,2] {
                            for i in listOfPolls{
                                if i.pollId == randPoll.pollId {
                                    append = false
                                }
                                
                            }
                            
                            if append == true{
                                listOfPolls.append(randPoll)
                                self.tableView.reloadData()
                            }
                        }
                    })
                    DispatchQueue.main.async {
                        self.removeAllOverlays()

                    }
                    self.downloadImage(from: URL(string: url!)!)
                    //first download extImp then qyer
                }
                
                
                
            }, failure: { (error: Error?, isUserLoggedOut: Bool) in
                
            })
            
            
         
            
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        impactFeedbackgenerator.prepare()
        let iconView = SCSDKBitmojiIconView()
        if let isArray = nameAndBitmojiArray {
            print(isArray)
        }
    iconView.frame = CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3) - 50, y: 50, width: 55, height: 55)
    iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bitmojiClicked)))
    view.addSubview(iconView)
    
        let newButton = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: (self.view.frame.height - 150), width: (self.view.frame.width/1.25), height: 45))
        newButton.center.x = self.view.center.x
        newButton.startPastelPoint = .bottomLeft
        newButton.endPastelPoint = .topRight
        newButton.animationDuration = 0.5
        newButton.startAnimation()
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonClicked)))
//        newButton.setColors([UIColor(red: 8/255, green: 41/255, blue: 224/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 91/255, blue: 163/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 72/255, blue: 163/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 121/255, blue: 163/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 155/255, blue: 163/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 54/255, blue: 163/255, alpha: 1.0),
//                             UIColor(red: 8/255, green: 142/255, blue: 163/255, alpha: 1.0)])
        
        //        newButton.layer.cornerRadius = 8.0
        //        newButton.clipsToBounds = true
        //        newButton.layer.masksToBounds = false
        newButton.setPastelGradient(.ariellesSmile)
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UserDefaults.standard.set(true, forKey: "loggedIn")
            UserDefaults.standard.synchronize()


        }
        
       self.tableView.reloadData()
    }
   

    
    @objc func buttonClicked() {
        impactFeedbackgenerator.impactOccurred()
        
        self.performSegue(withIdentifier: "createPollSegue", sender: self)
    }
    
    @objc func bitmojiClicked() {
        impactFeedbackgenerator.impactOccurred()
        let alert = UIAlertController(title: nameAndBitmojiArray?[0] ?? "Menu", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Contact Us", style: .default , handler:{ (UIAlertAction)in
             let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScHgHZ9K7O3ccBmhu95rA6mBc5x2FJV-cn-qh2WUIqMpNQK7g/viewform")
            let safariVC = SFSafariViewController(url: url!)
            self.present(safariVC, animated: true, completion: nil)
           
            

        }))
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.ref.child("users").child(extImp).updateChildValues(["fcmToken" : "User Signed Out"])
                self.showWaitOverlay()
            }
            
            SCSDKLoginClient.unlinkCurrentSession { (success: Bool) in
                if success == true {
                   // self.dismiss(animated: true, completion: nil)
                    DispatchQueue.main.async {
                        self.removeAllOverlays()
                        
                    UserDefaults.standard.set(false, forKey: "loggedIn")
                    self.performSegue(withIdentifier: "backToLogin", sender: self)
                    }
                    
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

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                bitmojiImage = UIImage(data: data)!
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    
}
