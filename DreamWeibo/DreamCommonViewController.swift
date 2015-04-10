//
//  DreamCommonViewControllerTableViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamCommonViewController: UITableViewController {

    var groups:NSMutableArray!
    
    init() {
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
        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 10
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0)
        groups = NSMutableArray()

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.groups.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.groups[section] as! DreamCommonGroup).items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = DreamCommonCell.cellWithTableView(tableView)
        let items = (self.groups[indexPath.section] as! DreamCommonGroup).items
        cell.item = items[indexPath.row] as! DreamCommonItem
        cell.numberOfSections = items.count
        cell.indexPath = indexPath
        
        return cell
    }

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let group = self.groups[section] as! DreamCommonGroup
        return group.footer
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = self.groups[section] as! DreamCommonGroup
        return group.header
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let items = (self.groups[indexPath.section] as! DreamCommonGroup).items
        let item = items[indexPath.row] as! DreamCommonItem

        
        if item.destVcClass != nil {
            let destVc = item.destVcClass.alloc() as! UIViewController
            destVc.title = item.title
            self.navigationController?.pushViewController(destVc, animated: true)
        }
        
        if item.operation != nil {
            item.operation()
        }
        
    }


}
