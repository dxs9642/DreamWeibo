//
//  DiscoverViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {

    var groups:NSMutableArray!
    
    override init() {
        super.init(style:
            UITableViewStyle.Grouped)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var searchBar = DreamSearchBar.buildSearchBar()
        self.navigationItem.titleView = searchBar
        
        groups = NSMutableArray()
        setupGroups()
        
        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 10
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0)

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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.groups.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        return (self.groups[section] as DreamCommonGroup).items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = DreamCommonCell.cellWithTableView(tableView)
        let items = (self.groups[indexPath.section] as DreamCommonGroup).items
        cell.item = items[indexPath.row] as DreamCommonItem
        cell.numberOfSections = items.count
        cell.indexPath = indexPath
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }

}
