//
//  YMCirCleButton.swift
//  YMPopMenu
//
//  Created by barryclass on 15/11/21.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

typealias eventBlock = ()->Void

class YMCirCleButton: UIView {

    var event:eventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        
    }
    
    convenience init(frame:CGRect, event:() -> Void) {
       
        self.init(frame:frame)
    
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addEvent(event: () -> Void) {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "performEvent")
        self.event = event
        self.addGestureRecognizer(tap)
    }
    
    func performEvent() {
        
        self.event!()
    
    }
    
    
    
    
    
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(ovalInRect: self.bounds)
        CGContextSetFillColorWithColor(ctx, UIColor.greenColor().CGColor)
        CGContextAddPath(ctx, path.CGPath)
        CGContextDrawPath(ctx, CGPathDrawingMode.Fill)
    }

}
