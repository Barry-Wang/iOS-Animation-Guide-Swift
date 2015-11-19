//
//  YMCircleLayer.swift
//  AnimationGuide
//
//  Created by barryclass on 15/11/13.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

enum MovePoint {
  
    // 连接点 A B C D 生成一个圆, Move_B 表示向左移动，移动B点
    
    case Move_B, Move_D
}

let OutSideRectSize:CGFloat = 120

class YMCircleLayer: CALayer {
   
    var outSideRect = CGRectZero
    var movePoint:MovePoint = MovePoint.Move_B
    var progress:Float = 0.5{
        
        didSet {
            
            let paddingWidth:CGFloat = (self.bounds.size.width - OutSideRectSize) / 2
            self.outSideRect = CGRectMake( (self.position.x - OutSideRectSize / 2) + CGFloat(progress - 0.5) * paddingWidth, self.position.y - OutSideRectSize / 2, OutSideRectSize, OutSideRectSize)
            
            if progress > 0.5 {
              self.movePoint = MovePoint.Move_B
            } else {
              self.movePoint = MovePoint.Move_D
            }
            
            // CALayer在第一次出现的时候不会主动调用 drawInContext
            self.setNeedsDisplay()
        }
    
    }
    
    
    
    override func drawInContext(ctx: CGContext) {
        
        //画最外面的正方形，在这个正方形里面画圆
        CGContextSetLineWidth(ctx, 5)
        CGContextSetStrokeColorWithColor(ctx, UIColor.greenColor().CGColor)
        // 设置为虚线模式
        CGContextSetLineDash(ctx, 0, [3,3], 2)
        CGContextStrokeRect(ctx, self.outSideRect)
        CGContextStrokePath(ctx)
        
        CGContextSetStrokeColorWithColor(ctx, UIColor.yellowColor().CGColor)
        
        // offset, moveDistance 都是些经验值
        let offset = OutSideRectSize / 3.6
        let moveDistance = (self.outSideRect.width * 1 / 6) * CGFloat(fabs(self.progress - 0.5) * 2)
        let rectCenter = CGPointMake(self.outSideRect.origin.x + OutSideRectSize / 2, self.outSideRect.origin.y + OutSideRectSize / 2)
        
        let point_A = CGPointMake(rectCenter.x, self.outSideRect.origin.y + moveDistance)
        // 当向左移动时，使B的x坐标增加，使其成近似椭圆状
        let point_B = CGPointMake(self.movePoint == MovePoint.Move_B ? rectCenter.x + OutSideRectSize / 2 + moveDistance * 2 : rectCenter.x + OutSideRectSize / 2, rectCenter.y)
        let point_C = CGPointMake(rectCenter.x, rectCenter.y + OutSideRectSize / 2 - moveDistance)
        let point_D = CGPointMake(self.movePoint == MovePoint.Move_D ? self.outSideRect.origin.x - moveDistance * 2 : self.outSideRect.origin.x, rectCenter.y)
        
        
//        let rectBizerpath = UIBezierPath()
//        rectBizerpath.moveToPoint(point_A)
//        rectBizerpath.addLineToPoint(point_B)
//        rectBizerpath.addLineToPoint(point_C)
//        rectBizerpath.addLineToPoint(point_D)
//        rectBizerpath.closePath()
//        CGContextAddPath(ctx, rectBizerpath.CGPath)
//        CGContextStrokePath(ctx)
        
        
        // 合成贝塞尔曲线所需要的控制点
        let point_AB1 = CGPointMake(point_A.x + offset, point_A.y)
        
        //判断控制点的位置使其形状变化更加真实
        let point_AB2 = CGPointMake(point_B.x, self.movePoint == MovePoint.Move_B ? point_B.y - offset + moveDistance : point_B.y - offset)
        
        let point_BC1 = CGPointMake(point_B.x, self.movePoint == MovePoint.Move_B ? point_B.y + offset - moveDistance : point_B.y + offset)
        let point_BC2 = CGPointMake(point_C.x + offset, point_C.y)
        
        let point_CD1 = CGPointMake(point_C.x - offset, point_C.y)
        let point_CD2 = CGPointMake(point_D.x, self.movePoint == MovePoint.Move_D ? point_D.y + offset - moveDistance : point_D.y + offset)
        
        let point_DA1 = CGPointMake(point_D.x, self.movePoint == MovePoint.Move_D ? point_D.y - offset + moveDistance : point_D.y - offset )
        let point_DA2 = CGPointMake(point_A.x - offset, point_A.y)
        
        let circlePath = UIBezierPath()
        CGContextSetLineDash(ctx, 0, nil, 0)
        CGContextSetStrokeColorWithColor(ctx, UIColor.purpleColor().CGColor)
        circlePath.moveToPoint(point_A)
        circlePath.addCurveToPoint(point_B, controlPoint1: point_AB1, controlPoint2: point_AB2)
        circlePath.addCurveToPoint(point_C, controlPoint1: point_BC1, controlPoint2: point_BC2)
        circlePath.addCurveToPoint(point_D, controlPoint1: point_CD1, controlPoint2: point_CD2)
        circlePath.addCurveToPoint(point_A, controlPoint1: point_DA1, controlPoint2: point_DA2)
        CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.orangeColor().CGColor)
        CGContextAddPath(ctx, circlePath.CGPath)
        CGContextDrawPath(ctx, CGPathDrawingMode.EOFillStroke)
        
        
    }
    
    
}
