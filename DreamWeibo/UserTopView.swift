//
//  UserTopView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class UserTopView: UIImageView {

    
    var profile:UIImageView!
    var nameLabel:UILabel!
    var vipView:UIImageView?

    override init(){
        super.init()
        
        self.image = UIImage(named: "user_info_background")
        
        setupTopSubviews()
   
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTopSubviews(){
        

        
        profile = UIImageView(image: UIImage(named: "default_avatar"))
        self.addSubview(profile)
        
        
        vipView = UIImageView()
        vipView?.contentMode = UIViewContentMode.Center
        vipView?.hidden = true;
        self.addSubview(vipView!)

        
        self.nameLabel = UILabel()
        nameLabel.text = "正在加载用户信息。。。。。"
        self.addSubview(nameLabel)

        
    }
    

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        profile.centerX = self.centerX;
        profile.y = 80
        

    }

    
    func getUserImage(urlString:NSString) -> UIImage? {
        
        var arr = urlString.componentsSeparatedByString("/")
        
        let userId:NSString = arr[3] as NSString
        
        let filePath = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as NSString)+"/"+userId+".jpg"
        
        let fm = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(filePath){
            
            let image = UIImage(contentsOfFile: filePath)
            return image
        }else{
            
                
            let imageUrl = NSURL(string: urlString)
            let request = NSURLRequest(URL: imageUrl!)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
                
                
                (response:NSURLResponse!,data:NSData!,error:NSError!) -> Void in
                
                let image = UIImage(data: data)
                
                UIImageJPEGRepresentation(image, 1.0).writeToFile(filePath, atomically: true)
                
                self.showProfile(image!)
                
            })
            

        }
        
        return nil
    }


    func showProfile(image:UIImage){
        
         let profileImage = UIImage.circleImageWithImage(image, borderWidth: 0, borderColor: UIColor.clearColor());
        let anim = CATransition()
        anim.duration = 1
        anim.type = "rippleEffect"
        self.profile.layer.addAnimation(anim, forKey: nil)
        self.profile.image = profileImage

        
    }
    
    func didShow(userInfo:DreamUser){
        
        let image = getUserImage(userInfo.avatar_large)
        
        if image != nil {
            showProfile(image!)
        }
        
        let font = DreamFont()
        self.nameLabel.font = font.DreamStatusOrginalNameFont
        
        let boundingSize = CGSizeMake(self.frame.size.width, CGFloat.max)
        var attr = NSMutableDictionary()

        attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
        let theName:NSString = userInfo.name
        let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
        self.nameLabel.size = nameSize.size
        
        self.nameLabel.centerX = self.centerX
        self.nameLabel.y = CGRectGetMaxY(self.profile.frame) + 10
        
        let vipX = CGRectGetMaxX(self.nameLabel.frame) + 10
        let vipY = nameLabel.y
        let vipH = nameSize.height
        let vipW = vipH
        
        let vipFrame = CGRectMake(vipX, vipY, vipW, vipH)
        
        
        self.nameLabel?.text = userInfo.name
        if userInfo.vip==true {
            self.nameLabel?.textColor = UIColor.orangeColor()
            self.vipView?.hidden = false
            self.vipView?.frame = vipFrame
            self.vipView?.image = UIImage(named: "common_icon_membership_level\(userInfo.mbrank)")
        }else{
            self.vipView?.hidden = true
            self.nameLabel?.textColor = UIColor.blackColor()
        }

    }
    
}
