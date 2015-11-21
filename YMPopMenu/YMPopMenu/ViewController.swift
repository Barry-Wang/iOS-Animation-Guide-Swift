//
//  ViewController.swift
//  YMPopMenu
//
//  Created by barryclass on 15/11/21.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let popMenu =  YMPopMenu(frame: CGRectMake(50, 100, 200, 200), count: 8)
        self.view.addSubview(popMenu)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

