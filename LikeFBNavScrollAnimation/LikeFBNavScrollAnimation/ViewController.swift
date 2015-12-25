//
//  ViewController.swift
//  LikeFBNavScrollAnimation
//
//  Created by barryclass on 15/12/25.
//  Copyright © 2015年 barry. All rights reserved.
//

import UIKit


let statusViewHeigt:CGFloat = 66
let initBarHeightY:CGFloat = 64
let initStatusHeightY:CGFloat = 20
let tabBarHeight:CGFloat = 49

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let statusView:UIView = UIView(frame: CGRect(x: 0, y: initBarHeightY, width: UIScreen.mainScreen().bounds.size.width, height: statusViewHeigt))
    let seperateView:UIView = UIView(frame: CGRect(x: 0, y: statusViewHeigt - 10, width: UIScreen.mainScreen().bounds.size.width, height: 10))
    
    let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 130, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 130 - tabBarHeight))
    
    
    var lastContentOffSetY:CGFloat = 0
    
    var tableViewRect = CGRectZero
    var statusViewRect = CGRectZero
    var navBarRect = CGRectZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.statusView.backgroundColor = UIColor.yellowColor()
        self.seperateView.backgroundColor = UIColor.grayColor()
        self.statusView .addSubview(self.seperateView)
        self.view.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.statusView)
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        
        tableViewRect = self.tableView.frame
        statusViewRect = self.statusView.frame
        navBarRect = (self.navigationController?.navigationBar.frame)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell!.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 当不能滚动时无论向上拉还是向下拉都无效,下向拉时还应该保证tableView在初始位置没有上移

        if  tableView.contentOffset.y > self.tableView.contentSize.height - self.tableView.bounds.size.height || (tableView.contentOffset.y <= 0 && tableViewRect.origin.y == 130) {
            
            
            return
        }
        
        // > 0 向上拉   < 0 向下拉
        let contentOffsetY = tableView.contentOffset.y - self.lastContentOffSetY
        
        tableViewRect = self.tableView.frame
        statusViewRect = self.statusView.frame
        navBarRect = (self.navigationController?.navigationBar.frame)!
        
        print("\(self.tableView.contentOffset.y)")
        if  contentOffsetY >= 0 {
            //最小位置为20，statusBar的下面
            if (self.tableView.frame.origin.y > initStatusHeightY) {
                
                // tableView 高度变小， 向上移动
                tableViewRect.origin.y -= contentOffsetY
                tableViewRect.size.height += contentOffsetY
                tableViewRect.origin.y = tableViewRect.origin.y < 20 ? 20 : tableViewRect.origin.y
                tableViewRect.size.height = tableViewRect.size.height > UIScreen.mainScreen().bounds.size.height - 69 ?  UIScreen.mainScreen().bounds.size.height - 69 : tableViewRect.size.height
                self.tableView.frame = tableViewRect
                
                
                // statusView 向上移动
                
                statusViewRect.origin.y -= contentOffsetY
                statusViewRect.origin.y = statusViewRect.origin.y < -44 ? -44 : statusViewRect.origin.y
                self.statusView.frame = statusViewRect
                
                
                // 向上移动NavgationBar
                if(self.tableView.frame.origin.y <= initBarHeightY) {
                    
                    navBarRect.origin.y -= contentOffsetY
                    navBarRect.origin.y = navBarRect.origin.y < -22 ? -22 : navBarRect.origin.y
                    self.navigationController?.navigationBar.frame = navBarRect
                }
                
                self.tableView.contentOffset.y = 0
                
            }
        } else {
            if (tableViewRect.origin.y < 130) {
                
                
                if statusViewRect.origin.y < initBarHeightY {
                    statusViewRect.origin.y -= contentOffsetY
                    statusViewRect.origin.y = statusViewRect.origin.y > initBarHeightY ? initBarHeightY : statusViewRect.origin.y
                    self.statusView.frame = statusViewRect
                    
                }
                
                if navBarRect.origin.y < initStatusHeightY {
                    
                    navBarRect.origin.y -= contentOffsetY
                    navBarRect.origin.y = navBarRect.origin.y > initStatusHeightY ? initStatusHeightY : (navBarRect.origin.y)
                    self.navigationController?.navigationBar.frame = navBarRect
                }
                
                tableViewRect.origin.y -= contentOffsetY
                tableViewRect.origin.y = tableViewRect.origin.y < 130 ? tableViewRect.origin.y : 130
                
                tableViewRect.size.height += contentOffsetY
                tableViewRect.size.height = tableViewRect.size.height < UIScreen.mainScreen().bounds.size.height - 179 ?  UIScreen.mainScreen().bounds.size.height - 179 : tableViewRect.size.height
                
                self.tableView.frame = tableViewRect
                
            }
        }
        
        self.lastContentOffSetY = self.tableView.contentOffset.y
        
        
        
    }
    
    
    func setHiddenFrame() {
        
        tableViewRect.origin.y = initStatusHeightY
        tableViewRect.size.height = UIScreen.mainScreen().bounds.height - 20 - tabBarHeight
        self.tableView.frame = tableViewRect
        
        navBarRect.origin.y = -24
        self.navigationController?.navigationBar.frame = navBarRect
        
        statusViewRect.origin.y = -40
        self.statusView.frame = statusViewRect
    }
    
    func setShowFrame() {
        
        tableViewRect.origin.y = 130
        tableViewRect.size.height = UIScreen.mainScreen().bounds.height - 130 - tabBarHeight
        self.tableView.frame = tableViewRect
        
        navBarRect.origin.y = initStatusHeightY
        self.navigationController?.navigationBar.frame = navBarRect
        
        statusViewRect.origin.y = 64
        self.statusView.frame = statusViewRect
        
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
                self.lastContentOffSetY = scrollView.contentOffset.y
    }
}

