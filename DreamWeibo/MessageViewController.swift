//
//  MessageViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发起聊天", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        

        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }



    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "message"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as UITableViewCell?
        
        if cell == nil{
            cell = MessageSimpleCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID,type: indexPath.row)
        }

        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    


}
