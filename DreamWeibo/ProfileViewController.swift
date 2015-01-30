//
//  ProfileViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class ProfileViewController: DreamCommonViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "设置", style: UIBarButtonItemStyle.Done, target: self, action: "setting")
        
        setupGroups()


    }
    
    func setting(){
        
        let setting = DreamSettingViewController()
        self.navigationController?.pushViewController(setting, animated: true)
//        HMSettingViewController *setting = [[HMSettingViewController alloc] init];
//        [self.navigationController pushViewController:setting animated:YES];
    }
    


    func setupGroups(){
        
        setupGroup0()
        setupGroup1()
    }
    

    
    func setupGroup0(){
        
        let group0 = DreamCommonGroup()
        
        
        let newFriend = DreamCommonArrowItem(title: "新的好友", icon: "new_friend")
        newFriend.badgeValue = "5";

        group0.items = [newFriend]
        
        self.groups.addObject(group0)
        
    }
    
    func setupGroup1(){
        
        let group1 = DreamCommonGroup()
        
        let album = DreamCommonArrowItem(title: "我的相册", icon: "album")
        album.subtitle = "(100)";
        
        let collect = DreamCommonArrowItem(title: "我的收藏", icon: "collect")
        collect.subtitle = "(10)";
        collect.badgeValue = "1";
        
        let like = DreamCommonArrowItem(title: "赞", icon: "like")
        like.subtitle = "(36)";
        like.badgeValue = "10";
        
        group1.items = [album, collect, like];
        
        self.groups.addObject(group1)
        
        
    }
    
    
    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }

}
