//
//  MessageSimpleCell.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/2/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageSimpleCell: UITableViewCell {

    
    var userSimple:MessageSimpleView!
    let bgView = UIImageView()
    let selectedBgView = UIImageView()
    var message:NSArray?
    var user:DreamUser?
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,type:NSInteger){
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        self.userInteractionEnabled = true
        userSimple = MessageSimpleView(type: type)
        self.contentView.addSubview(userSimple)
        self.backgroundColor = UIColor.clearColor()
        
        bgView.image = UIImage.resizeImage("common_card_middle_background")
        selectedBgView.image = UIImage.resizeImage("common_card_middle_background_highlighted")
        
        self.backgroundView = bgView
        self.selectedBackgroundView = selectedBgView
        
    }
    
    
    
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

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUserAndMessage(user:DreamUser,msg:NSArray){
        
        self.user = user
        self.message = msg
        self.userSimple.user = self.user
        self.userSimple.lastMessage = (self.message?.lastObject as DreamMessage).text
        self.userSimple.setupFromURL()
        self.userSimple.reloadInputViews()
        
    }
    

}
