//
//  MainViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/2/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let initViewController = WeiboTabBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = (NSBundle.mainBundle().loadNibNamed("MainView", owner: nil, options: nil) as NSArray).lastObject as UIView

        let leftMenu = DreamLeftMenu()
        let ScreenH = UIScreen.mainScreen().bounds.height
        leftMenu.width = 275
        leftMenu.height = 200
        leftMenu.y = 100
        self.view.addSubview(leftMenu)
        
        initViewController.view.frame = self.view.bounds
        self.view.addSubview(initViewController.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
