//
//  YMGooeySlideMenu.swift
//  Animation-Guide2-GooeySlideMenu
//
//  Created by barryclass on 15/11/19.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

let EXTRAAREA:CGFloat = 50

class YMGooeySlideMenu: UIView {
    
    var triggered = false
    var blurView:UIVisualEffectView = UIVisualEffectView(frame:CGRectZero)
    var displayLink:CADisplayLink?
    var animationCount = 0
    var helpSliderView:UIView
    var helpCenterView:UIView
    var diff:CGFloat = 0
    var keyWindow:UIWindow?
    init(titles:[String]) {
        
        helpSliderView = UIView(frame: CGRectMake(-40, 0,40, 40))
        helpCenterView = UIView(frame: CGRectZero)
        
        super.init(frame: CGRectMake(0, 0, 200, 200))
        
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
            
            self.keyWindow = window
            blurView = UIVisualEffectView(frame:window.bounds)
            blurView.effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            blurView.alpha = 0.0
            let tapGesture = UITapGestureRecognizer(target: self, action: "disappearMenu")
            blurView.addGestureRecognizer(tapGesture)
            window.addSubview(blurView)
            
            helpSliderView.backgroundColor = UIColor.redColor()
            window.addSubview(helpSliderView)
            helpSliderView.alpha = 0.0
            helpCenterView.frame = CGRectMake(-40, CGRectGetHeight(window.frame) / 2 - 20, 40, 40)
            helpCenterView.backgroundColor = UIColor.yellowColor()
            helpCenterView.alpha = 0.0
            window.addSubview(helpCenterView)
            
            
            self.backgroundColor = UIColor.clearColor()
            self.frame = CGRectMake(-window.frame.size.width / 2 - EXTRAAREA, 0, window.frame.width / 2 + EXTRAAREA, window.frame.size.height)
            window.insertSubview(self, belowSubview:helpSliderView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func triggeredMenu() {
      
        if !triggered {
            
            self.appearMenu()

            
        } else {
            
            self.disappearMenu()
            
       }
    
    }
    
    
    func  appearMenu() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.frame = self.bounds
            
        })
        
        self.beforeAnimation()
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [UIViewAnimationOptions.BeginFromCurrentState , UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            
            self.helpSliderView.center = CGPointMake((self.keyWindow?.center.x)!, self.helpCenterView.frame.size.height / 2)
            
            }, completion: { (sucess:Bool) -> Void in
                self.finishAnimation()
        })
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.blurView.alpha = 1.0
            
        })
        
        self.beforeAnimation()
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [UIViewAnimationOptions.BeginFromCurrentState , UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            
            self.helpCenterView.center = (self.keyWindow?.center)!
            
            }, completion: { (sucess:Bool) -> Void in
        })
        triggered = true
    
    }
    
    
    func disappearMenu() {
    
        UIView.animateWithDuration(0.3) { () -> Void in
            
            if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
                self.frame = CGRectMake(-window.frame.size.width / 2 - EXTRAAREA , 0, window.frame.width / 2 + EXTRAAREA, window.frame.size.height)
            }
        }
        
        self.beforeAnimation()
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            
            self.helpSliderView.center = CGPointMake(-self.helpSliderView.frame.size.height/2, self.helpSliderView.frame.size.height/2);

            }) { (sucess:Bool) -> Void in
                self.finishAnimation()
        }
        UIView.animateWithDuration(0.3) { () -> Void in

                self.blurView.alpha = 0.0
        }
        
        self.beforeAnimation()
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2.0, options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            
            self.helpCenterView.center = CGPointMake(-self.helpCenterView.frame.size.height/2, CGRectGetHeight(self.keyWindow!.frame)/2);
            
            }) { (sucess:Bool) -> Void in
                self.finishAnimation()
        }
        triggered = false
        
    }
    
    
    func beforeAnimation() {
    
        if self.displayLink == nil {
            self.displayLink = CADisplayLink(target: self, selector: "displayLinkAnimation")
            self.displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        }
        self.animationCount++
    }
    
    func finishAnimation() {
      
        self.animationCount--
        if self.animationCount == 0 {
          
            self.displayLink!.invalidate()
            self.displayLink = nil
        }
    }
    
    func displayLinkAnimation() {
        
      let slidePresentLayer  =   self.helpSliderView.layer.presentationLayer()
      let sliderFrame = slidePresentLayer?.valueForKeyPath("frame")?.CGRectValue
      let centerPresentLayer =   self.helpCenterView.layer.presentationLayer()
      let centerFrame = centerPresentLayer?.valueForKeyPath("frame")?.CGRectValue
      self.diff = (sliderFrame?.origin.x)! - (centerFrame?.origin.x)!
      self.setNeedsDisplay()
        
    }
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(self.frame.size.width - EXTRAAREA, 0))
        path.addQuadCurveToPoint(CGPointMake(self.frame.size.width - EXTRAAREA, self.frame.size.height), controlPoint: CGPointMake(self.keyWindow!.frame.size.width/2 + diff, self.keyWindow!.frame.size.height/2))
        path.addLineToPoint(CGPointMake(0, self.frame.size.height))
        path.closePath()
        let contextRef = UIGraphicsGetCurrentContext()
        CGContextAddPath(contextRef, path.CGPath)
        UIColor(colorLiteralRed: 0, green: 0.772, blue: 1, alpha: 1).set()
        CGContextFillPath(contextRef)
    }
}
