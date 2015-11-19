//
//  ViewController.swift
//  AnimationGuide
//
//  Created by barryclass on 15/11/13.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var circleView:YMCircleView = YMCircleView(frame: CGRectMake(30, 100, 300, 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circleView.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.circleView)
        
        let sliderBar = UISlider(frame: CGRectMake(0, 440, 300, 30))
        sliderBar.value = 0.5
        sliderBar.addTarget(self, action: "change:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(sliderBar)
        self.circleView.circleLayer.progress = sliderBar.value
        
    }
    
    func change(slideBar:UISlider) {
        self.circleView.circleLayer.progress = slideBar.value
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

