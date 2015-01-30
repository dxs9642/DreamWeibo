//
//  DreamGeneralSettingViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamGeneralSettingViewController: DreamCommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)

        self.setupGroups()


    
    }

    
    
    func setupGroups(){
        setupGroup0()
        setupGroup1()
        setupGroup2()
        
    }

    func setupGroup0(){
        let group = DreamCommonGroup()
        
        let readMode = DreamCommonLabelItem(title: "阅读模式")
        readMode.text = "有图模式"
        group.items = [readMode]
        
        self.groups.addObject(group)
    }
    func setupGroup1(){
        
    }
    func setupGroup2(){
        
    }
}
