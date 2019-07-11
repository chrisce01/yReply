//
//  FinalPollViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 29/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import SCSDKCreativeKit
import Pastel
import Firebase

class FinalPollViewController: UIViewController {
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)

    var snapAPI: SCSDKSnapAPI?
    var ref: DatabaseReference!
    @objc func snap() {
        impactFeedbackgenerator.impactOccurred()
        snapAPI?.startSnapping(completionHandler: { (error) in
            print(error?.localizedDescription)
        })
        
    }
    @objc func done() {
        impactFeedbackgenerator.impactOccurred()
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    func textToImageForTwoOptions(qText : NSString ,drawText: NSString, drawText2 : NSString, inImage: UIImage, atPoint: CGPoint, atPoint2 : CGPoint, qPoint : CGPoint) -> UIImage{
        
        // Setup the font specific variables
        var textColor = UIColor.black
        var textFont = UIFont(name: "Allerta", size: 14)!
        
        
        var qColor = UIColor.white
        var qFont = UIFont(name: "Allerta", size: 16)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let qFontAttributes = [
            NSAttributedString.Key.font: qFont,
            NSAttributedString.Key.foregroundColor: qColor,
        ]
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        
        // Create a point within the space that is as bit as the image
        var rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        var rect2 = CGRect(x: atPoint2.x, y: atPoint2.y, width: inImage.size.width, height: inImage.size.height)
        var qrect = CGRect(x: qPoint.x, y: qPoint.y, width: inImage.size.width, height: inImage.size.height)
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
       drawText2.draw(in: rect2, withAttributes: textFontAttributes)
        qText.draw(in: qrect, withAttributes: qFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage
        
    }
    
    
    func textToImageForThreeOptions(qText : NSString ,drawText: NSString, drawText2 : NSString, drawText3 : NSString, inImage: UIImage, atPoint: CGPoint, atPoint2 : CGPoint, atPoint3: CGPoint, qPoint : CGPoint) -> UIImage{
        
        // Setup the font specific variables
        var textColor = UIColor.black
        var textFont = UIFont(name: "Allerta", size: 14)!
        
        
        var qColor = UIColor.white
        var qFont = UIFont(name: "Allerta", size: 16)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let qFontAttributes = [
            NSAttributedString.Key.font: qFont,
            NSAttributedString.Key.foregroundColor: qColor,
        ]
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        
        // Create a point within the space that is as bit as the image
        var rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        var rect2 = CGRect(x: atPoint2.x, y: atPoint2.y, width: inImage.size.width, height: inImage.size.height)
        var rect3 = CGRect(x: atPoint3.x, y: atPoint3.y, width: inImage.size.width, height: inImage.size.height)
        var qrect = CGRect(x: qPoint.x, y: qPoint.y, width: inImage.size.width, height: inImage.size.height)
        
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        drawText2.draw(in: rect2, withAttributes: textFontAttributes)
        drawText3.draw(in: rect3, withAttributes: textFontAttributes)
        qText.draw(in: qrect, withAttributes: qFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage
        
    }
    
    
    func textToImageForFourOptions(qText : NSString ,drawText: NSString, drawText2 : NSString, drawText3 : NSString, drawText4: NSString, inImage: UIImage, atPoint: CGPoint, atPoint2 : CGPoint, atPoint3: CGPoint, atPoint4: CGPoint, qPoint : CGPoint) -> UIImage{
        
        // Setup the font specific variables
        var textColor = UIColor.black
        var textFont = UIFont(name: "Allerta", size: 14)!
        
        
        var qColor = UIColor.white
        var qFont = UIFont(name: "Allerta", size: 16)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let qFontAttributes = [
            NSAttributedString.Key.font: qFont,
            NSAttributedString.Key.foregroundColor: qColor,
        ]
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        
        // Create a point within the space that is as bit as the image
        var rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        var rect2 = CGRect(x: atPoint2.x, y: atPoint2.y, width: inImage.size.width, height: inImage.size.height)
        var rect3 = CGRect(x: atPoint3.x, y: atPoint3.y, width: inImage.size.width, height: inImage.size.height)
        var rect4 = CGRect(x: atPoint4.x, y: atPoint4.y, width: inImage.size.width, height: inImage.size.height)
        var qrect = CGRect(x: qPoint.x, y: qPoint.y, width: inImage.size.width, height: inImage.size.height)
        
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        drawText2.draw(in: rect2, withAttributes: textFontAttributes)
        drawText3.draw(in: rect3, withAttributes: textFontAttributes)
        drawText4.draw(in: rect4, withAttributes: textFontAttributes)
        qText.draw(in: qrect, withAttributes: qFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBOutlet weak var pollShow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()

            self.ref.child("users").child(extImp).updateChildValues(["fcmToken" : tokenUpload])

        }
        
        impactFeedbackgenerator.prepare()
        
        let newButton = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height - 90)), width: (self.view.frame.width/1.25), height: 45))
        newButton.center.x = self.view.center.x
        newButton.startPastelPoint = .bottomLeft
        newButton.endPastelPoint = .topRight
        newButton.animationDuration = 0.5
        newButton.startAnimation()
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(done)))
        newButton.setPastelGradient(.ariellesSmile)

        newButton.layer.shadowColor = UIColor.darkGray.cgColor
        newButton.layer.shadowOpacity = 1
        newButton.layer.shadowOffset = .zero
        newButton.layer.shadowRadius = 5
        newButton.layer.shadowPath = UIBezierPath(rect: newButton.bounds).cgPath
        let text = UILabel(frame: CGRect(x: (newButton.frame.width/2) - (newButton.frame.width/3) , y: (newButton.frame.height/2) - (newButton.frame.height/3) + 7 , width: newButton.frame.width/1.5, height: 15))
        text.textAlignment = .center
        //text.center.x = newButton.center.x
        
        
        
        text.text = "Done"
        text.textColor = .white
        
        newButton.addSubview(text)
        view.insertSubview(newButton, at: 0)
        
        
        
        let newButton1 = PastelView(frame:  CGRect(x: (self.view.frame.width/2)-(self.view.frame.width/3), y: ((self.view.frame.height - 160)), width: (self.view.frame.width/1.25), height: 45))
        newButton1.center.x = self.view.center.x
        newButton1.startPastelPoint = .bottomLeft
        newButton1.endPastelPoint = .topRight
        newButton1.animationDuration = 0.5
        newButton1.startAnimation()
        newButton1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(snap)))
        newButton1.setPastelGradient(.sunnyMorning)
        //        newButton.layer.cornerRadius = 8.0
        //        newButton.clipsToBounds = true
        //        newButton.layer.masksToBounds = false
        newButton1.layer.shadowColor = UIColor.darkGray.cgColor
        newButton1.layer.shadowOpacity = 1
        newButton1.layer.shadowOffset = .zero
        newButton1.layer.shadowRadius = 5
        newButton1.layer.shadowPath = UIBezierPath(rect: newButton.bounds).cgPath
        let text1 = UILabel(frame: CGRect(x: (newButton.frame.width/2) - (newButton.frame.width/3) , y: (newButton.frame.height/2) - (newButton.frame.height/3) + 7 , width: newButton.frame.width/1.5, height: 15))
        text1.textAlignment = .center
        //text.center.x = newButton.center.x
        
        
        
        text1.text = "👻 Share To Snap"
        text1.textColor = .black
        
        newButton1.addSubview(text1)
        view.insertSubview(newButton1, at: 0)
        
        
        if numOpt == 2{
        
        let image = UIImage(named: "two")!
        let newImage = textToImageForTwoOptions(qText: pollQDetails["question"] as! NSString, drawText: choice1Details["value"] as! NSString, drawText2: choice2Details["value"]! as! NSString, inImage: image, atPoint: CGPoint(x: 57, y: 98), atPoint2: CGPoint(x: 57, y: 164), qPoint: CGPoint(x: 50, y: 26))//
        var roundedImage = newImage.withRoundedCorners(radius: 20)!
            
        var smallBitmojiImage = resizeImage(image: bitmojiImage, newHeight: 110)
        pollShow.image = roundedImage.overlayWith(image: smallBitmojiImage, posX: 110, posY: -90)
        var stickerImage = roundedImage.overlayWith(image: smallBitmojiImage, posX: 105, posY: -90)
            stickerImage = stickerImage.overlayWith(image: UIImage(named: "madeWithy")!, posX: 50, posY: 380)
        
        /* Prepare a sticker image */
        let sticker = SCSDKSnapSticker(stickerImage: stickerImage)
        let snap = SCSDKNoSnapContent()
        snap.sticker = sticker
        snap.caption = ""
            snap.attachmentUrl = "https://yreply.me/" + "\(extImp)/" + "\(choice1Details["pollId"] as! String)"
           
        snapAPI = SCSDKSnapAPI(content: snap)
        }
        else if numOpt == 3 {
            let image = UIImage(named: "three")!
             let newImage = textToImageForThreeOptions(qText: pollQDetails["question"] as! NSString, drawText: choice1Details["value"] as! NSString, drawText2: choice2Details["value"]! as! NSString, drawText3: choice3Details["value"]! as! NSString, inImage: image, atPoint: CGPoint(x: 57, y: 98), atPoint2: CGPoint(x: 57, y: 164), atPoint3: CGPoint(x: 57, y: 230), qPoint: CGPoint(x: 50, y: 26))
            let roundedImage = newImage.withRoundedCorners(radius: 20)!
            var smallBitmojiImage = resizeImage(image: bitmojiImage, newHeight: 110)
            pollShow.image = roundedImage.overlayWith(image: smallBitmojiImage, posX: 110, posY: -90)
            var stickerImage = roundedImage.overlayWith(image: smallBitmojiImage, posX: 105, posY: -90)
            stickerImage = stickerImage.overlayWith(image: UIImage(named: "madeWithy")!, posX: 50, posY: 446)
            /* Prepare a sticker image */
            let sticker = SCSDKSnapSticker(stickerImage: stickerImage)
            let snap = SCSDKNoSnapContent()
            snap.sticker = sticker
            snap.caption = ""
            snap.attachmentUrl = "https://yreply.me/" + "\(extImp)/" + "\(choice1Details["pollId"] as! String)"
            snapAPI = SCSDKSnapAPI(content: snap)
            
        } else if numOpt == 4 {
            let image = UIImage(named: "four")!
            let newImage = textToImageForFourOptions(qText: pollQDetails["question"] as! NSString, drawText: choice1Details["value"] as! NSString, drawText2: choice2Details["value"]! as! NSString, drawText3: choice3Details["value"]! as! NSString, drawText4: choice4Details["value"]! as! NSString, inImage: image, atPoint: CGPoint(x: 57, y: 98), atPoint2: CGPoint(x: 57, y: 164), atPoint3: CGPoint(x: 57, y: 230), atPoint4: CGPoint(x: 57, y: 296), qPoint: CGPoint(x: 50, y: 26))
            let roundedImage = newImage.withRoundedCorners(radius: 20)!
            var smallBitmojiImage = resizeImage(image: bitmojiImage, newHeight: 110)
            pollShow.image = roundedImage.overlayWith(image: smallBitmojiImage, posX: 110, posY: -90)
            var stickerImage = roundedImage.overlayWith(image: smallBitmojiImage, posX: 105, posY: -90)
            stickerImage = stickerImage.overlayWith(image: UIImage(named: "madeWithy")!, posX: 50, posY: 505)

            /* Prepare a sticker image */
            let sticker = SCSDKSnapSticker(stickerImage: stickerImage)
            let snap = SCSDKNoSnapContent()
            snap.sticker = sticker
            snap.caption = ""
            snap.attachmentUrl = "https://yreply.me/" + "\(extImp)/" + "\(choice1Details["pollId"] as! String)"
            snapAPI = SCSDKSnapAPI(content: snap)
            
        }
    

        // Do any additional setup after loading the view.
    }
    
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
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

extension UIImage {
    // image with rounded corners
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
        
        func overlayWith(image: UIImage, posX: CGFloat, posY: CGFloat) -> UIImage {
            let newWidth = posX < 0 ? abs(posX) + max(self.size.width, image.size.width) :
                size.width < posX + image.size.width ? posX + image.size.width : size.width
            let newHeight = posY < 0 ? abs(posY) + max(size.height, image.size.height) :
                size.height < posY + image.size.height ? posY + image.size.height : size.height
            let newSize = CGSize(width: newWidth, height: newHeight)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            let originalPoint = CGPoint(x: posX < 0 ? abs(posX) : 0, y: posY < 0 ? abs(posY) : 0)
            self.draw(in: CGRect(origin: originalPoint, size: self.size))
            let overLayPoint = CGPoint(x: posX < 0 ? 0 : posX, y: posY < 0 ? 0 : posY)
            image.draw(in: CGRect(origin: overLayPoint, size: image.size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return newImage
        }
    

    
}
