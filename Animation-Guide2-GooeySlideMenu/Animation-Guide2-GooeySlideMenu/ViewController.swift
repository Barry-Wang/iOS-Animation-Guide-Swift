//
//  ViewController.swift
//  Animation-Guide2-GooeySlideMenu
//
//  Created by barryclass on 15/11/19.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var menu:YMGooeySlideMenu?


    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(300, 100, 30, 30)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("123", forState: UIControlState.Normal)
        button.addTarget(self, action: "triiger", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    
    
    
    func triiger() {
        if self.menu == nil {
            self.menu = YMGooeySlideMenu(titles: ["Hello"])
        }
       self.menu!.triggeredMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

