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
import SafariServices

var extImp = ""
var bitmojiImage : UIImage = UIImage()
var loadPollFromThis : NSDictionary = NSDictionary()

class ViewController: UIViewController {
    
    var ref: DatabaseReference!

    let bg = CheerView()
    let image1 = UIImage(named: "qmark1.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        UserDefaults.standard.set(false, forKey: "loggedIn")
        UserDefaults.standard.synchronize()

        ref = Database.database().reference()
        let loginButton = SCSDKLoginButton() { (success : Bool, error : Error?) in
            // do something
            if (error != nil){
                print("YEH HAI" + error!.localizedDescription)
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
                    extImp = "\(externalId!.replacingOccurrences(of: "/", with: ""))"
                    var bitmojiAvatarUrl: String?
                    if let bitmoji = me["bitmoji"] as? [String: Any] {
                        bitmojiAvatarUrl = bitmoji["avatar"] as? String
                        
                        // Essential to remove slashes from external id so that firebase doesn't make child after every slash
                        
                        self.ref.child("users").child(externalId!.replacingOccurrences(of: "/", with: "")).setValue(["displayName" : displayName ?? "Default", "bitmojiId" : bitmojiAvatarUrl ?? "NA", "fcmToken" : tokenUpload])

                        
                        Auth.auth().createUser(withEmail: externalId! + "@yreply.me", password: "hello123", completion: { (data, error) in
                            if error != nil {
                            }
                        })
                        
                        let url = bitmojiAvatarUrl
                        self.downloadImage(from: URL(string: url!)!)
                        
                    }
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    
                    let allDetails = [displayName, bitmojiAvatarUrl] as? Array<String>
                    DispatchQueue.main.async {
                        nameAndBitmojiArray = allDetails
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    
                }, failure: { (error: Error?, isUserLoggedOut: Bool) in
                                   })
            }
        }
        
        loginButton?.frame = CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height/2)+200), width: (self.view.frame.width/1.5), height: 45)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    
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

    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        UserDefaults.standard.synchronize()
        bg.frame = view.bounds
        view.addSubview(bg)
        
        bg.config.particle = .image([image1!])
        bg.config.customize = { cells in
            
            for i in cells {
                i.birthRate = 2
            }
        self.bg.start()
        }}
}

