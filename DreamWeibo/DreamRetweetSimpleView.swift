//
//  DreamRetweetSimpleView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamRetweetSimpleView: UIView {

    
    var status:DreamStatus!
    var icon:UIImageView!
    var nameLabel:UILabel!
    var content:UITextView!
    
    convenience init(status:DreamStatus) {
    
        self.init()
        self.status = status
        self.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        
        self.icon = UIImageView()
        self.icon.contentMode = UIViewContentMode.ScaleAspectFill
        self.icon.clipsToBounds = true
        self.addSubview(icon)
        if status.pic_urls.count > 0{
            let imageStr = (status.pic_urls[0] as DreamPhoto).thumbnail_pic
            icon.sd_setImageWithURL(NSURL(string: imageStr), placeholderImage: UIImage(named: "avatar_default_small"))
        }else if status.retweeted_status != nil && status.retweeted_status.pic_urls.count > 0{
            let imageStr = (status.retweeted_status.pic_urls[0] as DreamPhoto).thumbnail_pic
            icon.sd_setImageWithURL(NSURL(string: imageStr), placeholderImage: UIImage(named: "avatar_default_small"))
        }else{
            icon.sd_setImageWithURL(NSURL(string: status.user.avatar_large), placeholderImage: UIImage(named: "avatar_default_small"))
        }
        
        self.nameLabel = UILabel()
        self.addSubview(nameLabel)
        if self.status.retweeted_status != nil {
            self.nameLabel.text = "@\(status.retweeted_status.user.name)"
        }else{
            self.nameLabel.text = "@\(status.user.name)"
        }
        
        self.content = UITextView()
        self.content.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.content.scrollEnabled = false
        self.content.editable = false
        if self.status.retweeted_status != nil {
            
            let str:NSString = self.nameLabel.text!
            let attributeText = self.status.retweeted_status.attributedText
            let range = NSMakeRange(str.length+3,attributeText.length-str.length-3)
            self.content.attributedText = attributeText.attributedSubstringFromRange(range)
        }else{
            self.content.attributedText = self.status.attributedText
        }
        self.addSubview(content)
        
        
    }
    
    override init(){
        super.init()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.icon.x = 0;
        self.icon.y = 0;
        self.icon.width = self.height
        self.icon.height = self.height
        

        let font = DreamFont()
        self.nameLabel.font = font.DreamStatusOrginalNameFont
        let boundingSize = CGSizeMake(self.frame.size.width, CGFloat.max)
        var attr = NSMutableDictionary()
        attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
        let theName:NSString = nameLabel!.text!
        let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
        self.nameLabel.size = nameSize.size
        self.nameLabel.x = CGRectGetMaxX(self.icon.frame) + 5
        self.nameLabel.y = 5
        
        self.content.font = font.DreamStatusOrginalSourceFont
        self.content.x = self.nameLabel.x
        self.content.y = CGRectGetMaxY(self.nameLabel.frame)
        self.content.width = self.width - self.icon.width - 2 * 5
        self.content.height = self.height - self.content.y -  5
        
    }
    

}
