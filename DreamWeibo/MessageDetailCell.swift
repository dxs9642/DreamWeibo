//
//  MessageDetailCell.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageDetailCell: UITableViewCell {

    
    var message:DreamMessage!
    var senderImageFilePath:NSString!
    var showTime = true
    
    override init() {
        super.init()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,type:NSInteger){
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        let msgDetailView = MessageDetailView()
        msgDetailView.message = self.message
        msgDetailView.senderImageFilePath = self.senderImageFilePath
        msgDetailView.showTime = self.showTime
        self.contentView.addSubview(msgDetailView)
        self.backgroundColor = UIColor.clearColor()

        
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
