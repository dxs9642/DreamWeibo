//
//  DreamSimpleCell.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/29/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamSimpleCell: UITableViewCell {

    var simpleView:DreamSimpleView?
    var toolbar:DreamStatusToolBar?
    
    
    override init() {
        super.init()
        self.userInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        setupSimpleView()
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSimpleView(){
        
        var simpleView = DreamSimpleView()
        self.simpleView = simpleView
        self.contentView.addSubview(simpleView)
        
    }
    
    func setupSimpleFrame(simpleFrame:DreamSimpleFrame){
        
        self.simpleView?.setupSimpleFrame(simpleFrame)
        
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
