//
//  AnimationView.swift
//  keyFrameAnimation
//
//  Created by barryclass on 15/11/26.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class AnimationView: UIView {
   
    var path:UIBezierPath!
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    func beginAnimation() {

        
        
        
    
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        self.path = path
        path.addArcWithCenter(CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2), radius: 100, startAngle: 0, endAngle: (2.0 * CGFloat(M_PI)), clockwise: true)
        CGContextAddPath(context, path.CGPath)
        CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
//
        let boundingRect = CGRectMake(0, 0, 300, 300);
        let moveView = UIView(frame: CGRectMake(0,0,30,30))
        moveView.backgroundColor = UIColor.redColor()
        self.addSubview(moveView)
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation.path = CGPathCreateWithEllipseInRect(boundingRect, nil);
        keyframeAnimation.duration = 4
        keyframeAnimation.additive = true
        keyframeAnimation.repeatCount = HUGE
        keyframeAnimation.calculationMode = kCAAnimationCubicPaced
        keyframeAnimation.rotationMode = kCAAnimationRotateAuto
        moveView.layer.addAnimation(keyframeAnimation, forKey: "keyFrame")
        
        
    }

}
