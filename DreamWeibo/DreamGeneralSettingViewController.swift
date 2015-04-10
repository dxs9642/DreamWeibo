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
        
        let readMode = DreamCommonArrowItem(title: "阅读模式")

        group.items = [readMode]
        
        self.groups.addObject(group)
    }
    func setupGroup1(){
        let group = DreamCommonGroup()
 
        let clearCache = DreamCommonLabelItem(title: "清除缓存")
        clearCache.text = "null"
        let imageCachePath = SDImageCache.sharedImageCache().diskCachePath()
        let textDataPath =   (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/status.sqlite"
        
        let imageCacheSize = imageCachePath.fileSize()
        let textDataSize = textDataPath.fileSize()
        clearCache.subtitle = "现在的缓存数量是\( (imageCacheSize + textDataSize) / Int64(1024 * 1024))M"
        group.items = [clearCache]
        
        clearCache.operation =  {
            let a = 0
            MBProgressHUD.showMessage("正在清理缓存。。。。。")
            
            let mgr = NSFileManager.defaultManager()
            mgr.removeItemAtPath(imageCachePath, error: nil)
            mgr.removeItemAtPath(textDataPath, error: nil)
            clearCache.subtitle = nil
            self.tableView.reloadData()
            MBProgressHUD.hideHUD()
            
        }
        
        self.groups.addObject(group)
        
    }
    func setupGroup2(){
        
    }
    

}
