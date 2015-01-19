//
//  DreamLoadMoreFooter.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/18/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamLoadMoreFooter: UIView {

    @IBOutlet weak var loadView: UIActivityIndicatorView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var refreshing = false
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    class func footer() -> DreamLoadMoreFooter {
        return (NSBundle.mainBundle().loadNibNamed("DreamLoadMoreFooter", owner: nil, options: nil) as NSArray).lastObject as DreamLoadMoreFooter
    }
    
    
    
    func beginRefreshing(){
        self.statusLabel.text = "正在拼命加载更多数据..."
        self.loadView.startAnimating()
        self.refreshing = true;
    }
    
    func endRefreshing(){
        self.statusLabel.text = "上拉可以加载更多数据";
        self.loadView.stopAnimating()
        self.refreshing = false
    }
    

}
