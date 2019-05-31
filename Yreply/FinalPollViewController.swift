//
//  FinalPollViewController.swift
//  Yreply
//
//  Created by Akshat Jagga on 29/05/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import UIKit
import SCSDKCreativeKit

class FinalPollViewController: UIViewController {
    
    var snapAPI: SCSDKSnapAPI?
    
    @IBAction func snap(_ sender: Any) {
        
       
        
//        snapAPI?.startSnapping(snap) { [weak self] (error: Error?) in
//            self?.view.isUserInteractionEnabled = true
//
//            // Handle response
//        }
        
        snapAPI?.startSnapping(completionHandler: { (error) in
            
        })
        
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
    
    
    override func viewDidLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBOutlet weak var pollShow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let image = UIImage(named: "two")!
        
       //let roundedImage = makeRoundedImage(image: image, radius: 20.0)
        
        let newImage = textToImageForTwoOptions(qText: pollQDetails["question"] as! NSString, drawText: choice1Details["value"] as! NSString, drawText2: choice2Details["value"]! as! NSString, inImage: image, atPoint: CGPoint(x: 57, y: 98), atPoint2: CGPoint(x: 57, y: 164), qPoint: CGPoint(x: 50, y: 26))//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 280))
//        label.backgroundColor = UIColor.clear
//        label.textAlignment = .center
//        label.textColor = UIColor.black
//        label.text = "Hello test"
//        //label.drawText(in: CGRect(x: 45, y: 70, width: 320, height: 280))
//        label.draw(CGRect(x: 45, y: 70, width: 320, height: 280))
//
//        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
//        pollShow.layer.render(in: UIGraphicsGetCurrentContext()!)
//        label.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext();
        //let roundedImage = makeRoundedImage(image: newImage, radius: 20.0)
//        pollShow.layer.cornerRadius = 20.0
//        pollShow.clipsToBounds = true
        let roundedImage = newImage.withRoundedCorners(radius: 20)!
//        let completeImage = drawImage(image: bitmojiImage, inImage: roundedImage, atPoint: CGPoint(x: 120, y: -20))
        
        var smallBitmojiImage = resizeImage(image: bitmojiImage, newHeight: 110)
        pollShow.image = roundedImage.overlayWith(image: smallBitmojiImage, posX: 110, posY: -90)
        
        
        let stickerImage = roundedImage.overlayWith(image: smallBitmojiImage, posX: 105, posY: -90)
        /* Prepare a sticker image */
        let sticker = SCSDKSnapSticker(stickerImage: stickerImage)
        /* Alternatively, use a URL instead */
        // let sticker = SCSDKSnapSticker(stickerUrl: stickerImageUrl, isAnimated: false)
        
        /* Modeling a Snap using SCSDKNoSnapContent */
        let snap = SCSDKNoSnapContent()
        snap.sticker = sticker /* Optional */
        snap.caption = "" /* Optional */
        snap.attachmentUrl = "https://www.snapchat.com" /* Optional */
        
        
        snapAPI = SCSDKSnapAPI(content: snap)
    

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
    
//
//    func drawImage(image foreGroundImage:UIImage, inImage backgroundImage:UIImage, atPoint point:CGPoint) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, 0.0)
//        backgroundImage.draw(in: CGRect.init(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height))
//        foreGroundImage.draw(in: CGRect.init(x: point.x, y: point.y, width: foreGroundImage.size.width/1.25, height: foreGroundImage.size.height/1.25))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }

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
