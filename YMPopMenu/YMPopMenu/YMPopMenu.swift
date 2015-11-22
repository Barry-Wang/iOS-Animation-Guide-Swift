//
//  YMPopMenu.swift
//  YMPopMenu
//
//  Created by barryclass on 15/11/21.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class YMPopMenu: UIView {
    
    var innderDiameter:CGFloat = 0
    var boudsCenterX:CGFloat = 0
    var boudsCenterY:CGFloat = 0
    var buttonArray:[YMCirCleButton] = [YMCirCleButton]()
    var centerButton = YMCirCleButton(frame: CGRectMake(0,0,0,0))
    var avergeRadius = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.innderDiameter = self.frame.size.width / 2 - 30
        self.boudsCenterX = self.frame.size.width / 2
        self.boudsCenterY = self.frame.size.height / 2
    }
    
    
    convenience init(frame:CGRect, count:NSInteger) {
        
        self.init(frame: frame)
        self.avergeRadius = 360 / count
        self.centerButton.frame = CGRectMake(0, 0, self.boudsCenterX, self.boudsCenterX)
        self.centerButton.center = CGPointMake(self.boudsCenterX, self.boudsCenterY)
        self.centerButton.addEvent { () -> Void in
            print("come here")
            self.showMenu()
        }
        self.addSubview(centerButton)
        
        for var i = 0; i < count; i++ {
            let button = YMCirCleButton(frame: CGRectMake(self.boudsCenterX - 15, self.boudsCenterY - 15, 0,    0))
            self.buttonArray.append(button)
            self.addSubview(button)
        }
        
    }
    
    
    func getCirclePoint(radius:CGFloat)->(x:CGFloat, y:CGFloat) {
        switch radius {
        case 0:
            return(self.boudsCenterX, self.boudsCenterY - self.innderDiameter)
        case 90:
            return(self.boudsCenterX + self.innderDiameter, self.boudsCenterY)
        case 180:
            return (self.boudsCenterX, self.boudsCenterY + self.innderDiameter)
        case 270:
            return (self.boudsCenterX - self.innderDiameter, self.boudsCenterY)
        default:
            let x = sin(Double(radius) * M_PI / 180)  * Double(self.innderDiameter)
            let y = cos(Double(radius) * M_PI / 180) * Double(self.innderDiameter)
            return(self.boudsCenterX + CGFloat(x), self.boudsCenterY - CGFloat(y))
        }
    
    }
    
    func showMenu () {
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            
            for var i = 0; i < self.buttonArray.count; i++ {
                let button = self.buttonArray[i]
                let centerPoint:(x:CGFloat, y:CGFloat) = self.getCirclePoint(CGFloat(self.avergeRadius * i))
                button.frame = CGRectMake(centerPoint.x - 15, centerPoint.y - 15, 30, 30)
                button.setNeedsDisplay()
            }
            self.transform = CGAffineTransformMakeRotation(-360)
            self.centerButton.alpha = 0.0
            
            }) { (sucess:Bool) -> Void in
                
        }
        
    }
    
    func disappearMenu() {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            
            for var i = 0; i < self.buttonArray.count; i++ {
                let button = self.buttonArray[i]
                button.frame = CGRectMake(self.boudsCenterX - 15, self.boudsCenterY - 15, 30,    30)
                button.setNeedsDisplay()
            }
            self.centerButton.alpha = 1.0
            self.transform = CGAffineTransformMakeRotation(360)

            }) { (sucess:Bool) -> Void in
                for button in self.buttonArray {
                    button.frame = CGRectMake(self.boudsCenterX - 15, self.boudsCenterY - 15, 0,    0)
                }

        }
        
    
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
