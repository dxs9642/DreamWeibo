//
//  DreamViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamNavigationViewController: UINavigationController {

    
    
    private var once = dispatch_once_t()
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        

        
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_back", imageHighlight: "navigationbar_back_highlighted", target: self, action: "back")
            
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_more", imageHighlight: "navigationbar_pop_highlighted", target: self, action: "more")
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back(){
        self.popViewControllerAnimated(true)
    }
    
    func more(){
        self.popToRootViewControllerAnimated(true)
    }
    
    
 
}
