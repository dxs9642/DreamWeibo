//
//  ComposeViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发微博"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: nil, action:"cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: nil, action: "send")
        self.navigationItem.rightBarButtonItem?.enabled = false
        
    }
    
    func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func send(){
        
    }
    
    


}
