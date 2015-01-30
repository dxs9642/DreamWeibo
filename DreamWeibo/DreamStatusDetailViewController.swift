//
//  DreamStatusDetailViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var status:DreamStatus!
    var tableView:UITableView!
    var bottomToolbar:DreamStatusDetailBottomToolbar!
    lazy var toolbar = DreamStatusDetailTopToolbar.toolbar

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "微博正文"
        self.setupTableView()
        self.setupDetailView()
        self.setupBottomToolbar()
        
        
    }
    

    
    func setupBottomToolbar(){
        bottomToolbar = DreamStatusDetailBottomToolbar()
        
        bottomToolbar.y = CGRectGetMaxY(self.tableView.frame)
            
            
        bottomToolbar.width = self.view.width
        bottomToolbar.height = self.view.height - self.tableView.height
        
        self.view.addSubview(bottomToolbar)
        
    }
    
    func setupTableView(){
        tableView = UITableView()
        
        tableView.width = self.view.width
        tableView.height = self.view.height - 35
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.view.addSubview(tableView)
    }
    
    
    func setupDetailView(){
        let totalView = UIView()
        let emptyView = UIView()
        totalView.width = self.tableView.width
        emptyView.width = self.tableView.width
        emptyView.height = 30
        let detailView = DreamStatusDetailView()
        let frame = DreamStatusDetailFrame()
        if self.status.retweeted_status != nil {
            self.status.retweeted_status.detail = true
        }
        frame.status = self.status
        detailView.setupDetailFrame(frame)
        detailView.height = frame.frame.size.height
        totalView.height = detailView.height + 25
        totalView.addSubview(detailView)
        emptyView.y = detailView.height
        emptyView.backgroundColor = UIColor.clearColor()
        totalView.addSubview(emptyView)
        self.tableView.tableHeaderView = totalView
        
        
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        cell!.textLabel?.text = "123123123"
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.toolbar
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.toolbar.height
    }
    

}
