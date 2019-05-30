//
//  PastelView.swift
//  Pastel
//
//  Created by Cruz on 05/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class PastelView: UIView {

    private struct Animation {
        static let keyPath = "colors"
        static let key = "ColorChange"
    }
    
    //MARK: - Custom Direction

    open var startPoint: CGPoint = PastelPoint.topRight.point
    open var endPoint: CGPoint = PastelPoint.bottomLeft.point
    
    open var startPastelPoint = PastelPoint.topRight {
        didSet {
            startPoint = startPastelPoint.point
        }
    }
    
    open var endPastelPoint = PastelPoint.bottomLeft {
        didSet {
            endPoint = endPastelPoint.point
        }
    }
    
    //MARK: - Custom Duration

    open var animationDuration: TimeInterval = 5.0
    
    fileprivate let gradient = CAGradientLayer()
    private var currentGradient: Int = 0
    private var colors: [UIColor] = [#colorLiteral(red: 0.0862745098, green: 0.8509803922, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.1882352941, green: 0.7803921569, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.2745098039, green: 0.6823529412, blue: 0.968627451, alpha: 1)]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    public func startAnimation() {
        gradient.removeAllAnimations()
        setup()
        animateGradient()
    }
    
    fileprivate func setup() {
        gradient.frame = bounds
        gradient.colors = currentGradientSet()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.drawsAsynchronously = true
        
        layer.insertSublayer(gradient, at: 0)
    }

    fileprivate func currentGradientSet() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        return [colors[currentGradient % colors.count].cgColor,
                colors[(currentGradient + 1) % colors.count].cgColor]
    }
    
    public func setColors(_ colors: [UIColor]) {
        guard colors.count > 0 else { return }
        self.colors = colors
    }
    
    public func setPastelGradient(_ gradient: PastelGradient) {
        setColors(gradient.colors())
    }
    
    public func addcolor(_ color: UIColor) {
        self.colors.append(color)
    }
    
    func animateGradient() {
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: Animation.keyPath)
        animation.duration = animationDuration
        animation.toValue = currentGradientSet()
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradient.add(animation, forKey: Animation.key)
    }
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }
}

extension PastelView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = currentGradientSet()
            animateGradient()
        }
    }
}
