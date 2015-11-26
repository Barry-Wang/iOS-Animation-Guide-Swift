////  ViewController.swift
//  keyFrameAnimation
//
//  Created by barryclass on 15/11/26.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let animationView = ThreeCircleMoveView(frame:CGRectMake(50,50,300,300))
        animationView.layer.transform = CATransform3DIdentity
       // animationView.layer.transform = CATransform3DMakeRotation(90 * CGFloat(M_PI) / 180, 0, 0, 1)
       // animationView.transform = CGAffineTransformMakeRotation(90 * CGFloat(M_PI) / 180)
        self.view.addSubview(animationView)
        self.view.backgroundColor = UIColor.blueColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func drawSomeThing() {

    }


}

