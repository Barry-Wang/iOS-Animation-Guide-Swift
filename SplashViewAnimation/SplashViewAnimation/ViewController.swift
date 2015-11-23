//
//  ViewController.swift
//  SplashViewAnimation
//
//  Created by barryclass on 15/11/23.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    // 在开始状态时，我们可以看到mask后的内容，为了遮挡后面的内容增加一个View
    @IBOutlet weak var maskWhiteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.imageView.image = UIImage(named: "logo")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController!.view.layer.mask = CALayer()
        self.navigationController!.view.layer.mask!.contents = UIImage(named: "logo.png")!.CGImage
        self.navigationController!.view.layer.mask!.position = self.view.center
        self.navigationController!.view.layer.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height:100)
        
        
        let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimation.delegate = self
        transformAnimation.duration = 1
        transformAnimation.beginTime = CACurrentMediaTime() + 1
        
        
        // 先缩小后变大
        let initalBounds = NSValue(CGRect: self.navigationController!.view.layer.mask!.bounds)
        let secondBounds = NSValue(CGRect:CGRect(x: 0, y: 0, width: 50, height: 50))
        let finalBounds = NSValue(CGRect:CGRect(x: 0, y: 0, width: 2000, height: 2000))
        
        
        transformAnimation.values = [initalBounds, secondBounds, finalBounds]
        
        // 每个value 发生时的时间结点,动画在0秒时为initalBounds，0.2秒时为secondBounds 1秒时为finalBounds
        transformAnimation.keyTimes = [0, 0.2,1]
        
        // bounds 动画两次 initalBounds -> secondBounds -> finalBounds,所以设置了两个时间函数
        // kCAMediaTimingFunctionEaseInEaseOut  慢进慢出
        // kCAMediaTimingFunctionEaseOut   快进慢出
        // kCAMediaTimingFunctionEaseIn    慢进快出
        
        transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        // 是否移除Presentation Layer,如果移除就会回到动画前的状态
        transformAnimation.removedOnCompletion = false
        
        /*
            kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态。

            KCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态。

            KCAFillModeBackwards 这个和 kCAFillModeForwards 是相对的，就是在动画开始前，你只要将动画加入了一个layer，layer便立即进								入动画的初始状态并等待动画开始。你可以这样设定测试代	码，将一个动画加入一个layer的时候延迟5秒执行。然后就会发现在动画没有开始的时候，只要动画被加入了ayer , layer 便处于动画初始状态， 动画结束后，layer 也会恢复到之前的状态。
             KCAFillModeBoth        理解了上面两个，这个就很好理解了，这个其实就是上面两个的合成。动画加入后立即开始，layer便处

         */
        transformAnimation.fillMode = kCAFillModeForwards
        self.navigationController!.view.layer.mask!.addAnimation(transformAnimation, forKey: "maskAnimation")
        
        // 给 View增加一个弹性效果，先这大后变小
        UIView.animateWithDuration(0.25,
        delay: 1.2,
        options: UIViewAnimationOptions.TransitionNone,
        animations: {
            self.navigationController!.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
            },
            completion: { finished in
                UIView.animateWithDuration(0.3,
                    delay: 0.0,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations: {
                        self.navigationController!.view.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        })
        
        UIView.animateWithDuration(0.1,
            delay: 1.25,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.maskWhiteView.alpha = 0.0
            },
            completion: { finished in
                self.maskWhiteView.removeFromSuperview()
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

