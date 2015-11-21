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
    var buttonArray:[YMCirCleButton]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        self.innderDiameter = self.frame.size.width / 2 - 40
        self.boudsCenterX = self.frame.size.width / 2
        self.boudsCenterY = self.frame.size.height / 2
        
        
        print("self.center = \(self.center)")

//        
        for var i = 0; i < 8; i++ {
            let centerPoint:(x:CGFloat, y:CGFloat) = self.getCirclePoint(CGFloat(i * 45))
            print("centerPoint = \(i * 45 ) = \(centerPoint)")
            let button = YMCirCleButton(frame: CGRectMake(centerPoint.x - 20, centerPoint.y - 20, 40, 40))
            buttonArray?.append(button)
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
