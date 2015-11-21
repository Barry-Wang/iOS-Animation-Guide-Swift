//
//  YMCirCleButton.swift
//  YMPopMenu
//
//  Created by barryclass on 15/11/21.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class YMCirCleButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(ovalInRect: self.bounds)
        CGContextSetFillColorWithColor(ctx, UIColor.greenColor().CGColor)
        CGContextSetStrokeColorWithColor(ctx, UIColor.purpleColor().CGColor)
        CGContextAddPath(ctx, path.CGPath)
        CGContextDrawPath(ctx, CGPathDrawingMode.EOFillStroke)
    }

}
