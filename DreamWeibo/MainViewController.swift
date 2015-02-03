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
    
    let leftMenu = DreamLeftMenu()
    let rightMenu = DreamRightMenu()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "IMG_0006")
        bgImage.frame = self.view.bounds
        self.view.addSubview(bgImage)
        
        let ScreenH = UIScreen.mainScreen().bounds.height
        leftMenu.width = 275
        leftMenu.height = 200
        leftMenu.y = 100
        self.view.addSubview(leftMenu)
        

        let screenW = UIScreen.mainScreen().bounds.width
        rightMenu.width = 275
        rightMenu.height = 200
        rightMenu.y = 100
        rightMenu.x = screenW - 275
        self.view.addSubview(rightMenu)
        
        initViewController.view.frame = self.view.bounds
        self.view.addSubview(initViewController.view)

 
        
        // Do any additional setup after loading the view.
    }
}
