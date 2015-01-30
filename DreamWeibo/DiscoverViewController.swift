//
//  DiscoverViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DiscoverViewController: DreamCommonViewController {

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var searchBar = DreamSearchBar.buildSearchBar()
        self.navigationItem.titleView = searchBar
        
        setupGroups()
        

    }

    
    func setupGroups(){
 
        setupGroup0()
        setupGroup1()
        setupGroup2()
    }
    
    func setupGroup0(){
        
        let group0 = DreamCommonGroup()
        
        
        let hotStatus = DreamCommonItem(title: "热门微博", icon: "hot_status")
        hotStatus.subtitle = "本地微博发现你身边的新鲜事"
        let findPeople = DreamCommonItem(title: "找人", icon: "find_people")
        findPeople.subtitle = "看明星、找有趣的人，尽在这里"
        group0.items = [hotStatus, findPeople]

        self.groups.addObject(group0)

    }
    func setupGroup1(){
        
        let group1 = DreamCommonGroup()
        
        let gameCenter = DreamCommonItem(title: "游戏中心", icon: "game_center")
        let near = DreamCommonItem(title: "周边", icon: "near")
        let app = DreamCommonItem(title: "应用", icon: "app")
        

        group1.items = [gameCenter, near, app];
        
        self.groups.addObject(group1)

        
    }
    func setupGroup2(){
        
        let group2 = DreamCommonGroup()

        let video = DreamCommonItem(title: "视频", icon: "video")
        let music = DreamCommonItem(title: "音乐", icon: "music")
        let movie = DreamCommonItem(title: "电影", icon: "movie")
        let cast = DreamCommonItem(title: "播客", icon: "cast")
        let more = DreamCommonItem(title: "更多", icon: "more")

        
        
        group2.items = [video, music, movie, cast, more];
        
        self.groups.addObject(group2)

    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }

}
