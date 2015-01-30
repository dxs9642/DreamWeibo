//
//  DreamSettingViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamSettingViewController: DreamCommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        self.setupGroups()
        self.setupFooter()
        
    }
    
    
    func setupFooter(){
        
        let logout = UIButton()
        
        logout.titleLabel?.font = UIFont.systemFontOfSize(14)
        logout.setTitle("退出当前账号", forState: UIControlState.Normal)
        let color = UIColor(red: 1, green: 10/255, blue: 10/255, alpha: 1.0)
        logout.setTitleColor(color, forState: UIControlState.Normal)
        logout.setBackgroundImage(UIImage.resizeImage("common_card_background"), forState: UIControlState.Normal)
        logout.setBackgroundImage(UIImage.resizeImage("common_card_background_highlighted"), forState: UIControlState.Highlighted)

        logout.height = 35
        self.tableView.tableFooterView = logout
        
        
        
        
    }
    

    
    func setupGroups(){
        setupGroup0()
        setupGroup1()
        setupGroup2()
        
    }
    
    
    
    func setupGroup0(){
        let group = DreamCommonGroup()
        group.footer = "tail部"
        
        let account = DreamCommonArrowItem(title: "帐号管理")
        group.items = [account]
        
        self.groups.addObject(group)
    }
    
    
    func setupGroup1(){
        
        let group = DreamCommonGroup()
        
        let account = DreamCommonArrowItem(title: "主题、背景")
        group.items = [account]
        
        self.groups.addObject(group)

        
        
        
    }
    func setupGroup2(){
        
        let group = DreamCommonGroup()
        group.header = "头部"
        
        let generalSetting = DreamCommonArrowItem(title: "通用设置")
        generalSetting.destVcClass = DreamGeneralSettingViewController().classForCoder

        group.items = [generalSetting]

        
        self.groups.addObject(group)
        
    }
    
    
    
    
    
    
    
    


}
