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
    
    
    

    func setupDetailContent(messageFrame:MessageDetailViewFrame,senderImageFilePath:NSString){
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        msgDetailView = MessageDetailView(senderImageFilePath: senderImageFilePath)
        msgDetailView.msgFrame = messageFrame

        for content in self.contentView.subviews {
            let contentView = content as! UIView
            contentView.removeFromSuperview()
        }
        
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
