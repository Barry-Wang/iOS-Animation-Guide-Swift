//
//  ViewController.swift
//  AnimationTest
//
//  Created by barryclass on 15/11/24.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        self.loginFailAnimation()
    }
    
    
    func loginFailAnimation() {
       
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position.x")
        keyFrameAnimation.values = [0, 10, -10, 10, 0]
        keyFrameAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        keyFrameAnimation.duration = 0.4
        keyFrameAnimation.additive = true
        keyFrameAnimation.repeatCount = 2
        self.passwordTextField.layer.addAnimation(keyFrameAnimation, forKey: "basic")
    }
    
}

