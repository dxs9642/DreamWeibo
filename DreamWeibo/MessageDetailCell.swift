//
//  MessageDetailCell.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageDetailCell: UITableViewCell {

    var msgDetailView:MessageDetailView!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,message:DreamMessage,showTime:Bool,senderImageFilePath:NSString){
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        msgDetailView = MessageDetailView(senderImageFilePath: senderImageFilePath)
        msgDetailView.message = message
        msgDetailView.showTime = showTime
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
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    

    
    
}
