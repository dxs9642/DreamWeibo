//
//  HomeTableViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_friendsearch", imageHighlight: "navigationbar_friendsearch_highlighted", target:self,action: "friendSearch")

                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_pop", imageHighlight: "navigationbar_pop_highlighted", target:self ,action: "pop")
        
    }
    
    

    
    func friendSearch(){
        print("123")
    }
    func pop(){
        print("123")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }
    


}
