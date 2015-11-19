//
//  YMCircleView.swift
//  AnimationGuide
//
//  Created by barryclass on 15/11/13.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class YMCircleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var circleLayer:YMCircleLayer
    
    override init(frame: CGRect) {
        self.circleLayer = YMCircleLayer()
        super.init(frame: frame)
        self.circleLayer.frame = self.bounds;
        self.layer.addSublayer(self.circleLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
