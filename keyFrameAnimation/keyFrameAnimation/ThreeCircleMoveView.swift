//
//  ThreeCircleMoveView.swift
//  keyFrameAnimation
//
//  Created by barryclass on 15/11/26.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ThreeCircleMoveView: UIView {

  
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineCap(ctx, CGLineCap.Round)
        CGContextSetLineJoin(ctx, CGLineJoin.Round)

        let centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2)
        let path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(centerPoint.x, centerPoint.y))
        path.addQuadCurveToPoint(CGPointMake(centerPoint.x + 100, centerPoint.y), controlPoint: CGPointMake(centerPoint.x + 50, centerPoint.y - 150))
        path.addQuadCurveToPoint(centerPoint, controlPoint: CGPointMake(centerPoint.x + 60, centerPoint.y + 150))
        path.addQuadCurveToPoint(CGPointMake(centerPoint.x - 110, centerPoint.y), controlPoint: CGPointMake(centerPoint.x - 50, centerPoint.y - 150))
        path.addQuadCurveToPoint(centerPoint, controlPoint: CGPointMake(centerPoint.x - 50, centerPoint.y + 150))
        CGContextAddPath(ctx, path.CGPath)
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke)
        
        
        let moveView = UIView(frame: CGRectMake(0,0,30,30))
        moveView.backgroundColor = UIColor.redColor()
        moveView.layer.cornerRadius = 15
        self.addSubview(moveView)
        //moveView.layer.transform = CATransform3DMakeRotation(-90 * CGFloat(M_PI) / 180, 1, 0, 0)

        
        let moveView2 = UIView(frame: CGRectMake(0,0,30,30))
        moveView2.backgroundColor = UIColor.greenColor()
        moveView2.layer.cornerRadius = 15
        self.addSubview(moveView2)
        
        let moveView3 = UIView(frame: CGRectMake(0,0,30,30))
        moveView3.backgroundColor = UIColor.blueColor()
        moveView3.layer.cornerRadius = 15
        self.addSubview(moveView3)
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation.path = path.CGPath
        keyframeAnimation.duration = 3
        keyframeAnimation.additive = true
        keyframeAnimation.repeatCount = HUGE
        keyframeAnimation.calculationMode = kCAAnimationCubicPaced
        keyframeAnimation.rotationMode = kCAAnimationRotateAuto
        moveView.layer.addAnimation(keyframeAnimation, forKey: "keyFrame")
        
        keyframeAnimation.beginTime = CACurrentMediaTime() + 1.2
        moveView2.layer.addAnimation(keyframeAnimation, forKey: "keyFrame")
        
        keyframeAnimation.beginTime = CACurrentMediaTime() + 2.4
        moveView3.layer.addAnimation(keyframeAnimation, forKey: "keyFrame")

        
        
    }
 

}
