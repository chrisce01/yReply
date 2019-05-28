//
//  ViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 27/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import SCSDKLoginKit
import Cheers
import Firebase


class ViewController: UIViewController {
    
    var ref: DatabaseReference!

    let bg = CheerView()
    let image1 = UIImage(named: "qmark1.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        let loginButton = SCSDKLoginButton() { (success : Bool, error : Error?) in
            // do something
            if (error != nil){
                print("Error")
            }
            else {
                let graphQLQuery = "{me{displayName, bitmoji{avatar}, externalId}}"
                
                let variables = ["page": "bitmoji"]
                
                SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: variables, success: { (resources: [AnyHashable: Any]?) in
                    guard let resources = resources,
                        let data = resources["data"] as? [String: Any],
                        let me = data["me"] as? [String: Any] else { return }
                        let externalId = me["externalId"] as? String
                    let displayName = me["displayName"] as? String
                    var bitmojiAvatarUrl: String?
                    if let bitmoji = me["bitmoji"] as? [String: Any] {
                        bitmojiAvatarUrl = bitmoji["avatar"] as? String
                        
                        // Essential to remove slashes from external id so that firebase doesn't make child after every slash
                        
                        self.ref.child("users").child(externalId!.replacingOccurrences(of: "/", with: "")).setValue(["displayName" : displayName!, "bitmojiId" : bitmojiAvatarUrl ?? "NA"])
                       


                        Auth.auth().createUser(withEmail: externalId! + "@yreply.me", password: "hello123", completion: { (data, error) in
                            if error != nil {
                            }
                        })
                    }
                    
                    
                    let allDetails = [displayName, bitmojiAvatarUrl] as! Array<String>
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSegue", sender: allDetails)
                    }
                    
                }, failure: { (error: Error?, isUserLoggedOut: Bool) in
                    // handle error
                })
            }
        }
        
        loginButton?.frame = CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height/2)+300), width: (self.view.frame.width/1.5), height: 45)
        loginButton!.center.x = self.view.center.x
        bg.frame = view.bounds
        view.addSubview(bg)
        view.addSubview((loginButton ?? nil)!)
        bg.config.particle = .image([image1!])
        bg.config.customize = { cells in
            
            for i in cells {
                i.birthRate = 2
            }
        }
        bg.start()
        
    }

    override func viewDidLayoutSubviews() {
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if let destVc = segue.destination as? MainScreenViewController {
                if let dets = sender as? Array<String> {
                    destVc.nameAndBitmojiArray = dets
                }
            }
        }
    }

}

