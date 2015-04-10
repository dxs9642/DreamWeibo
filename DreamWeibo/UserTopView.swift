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
    var infoLabelLeft:UILabel!
    var infoLabelRight:UILabel!
    var infoLabelCenter:UILabel!
    var vipView:UIImageView?

    
    
    convenience init(){
        let frame = CGRectMake(0, 0, 0, 0)
        self.init(frame:frame)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "user_info_background")
        
        setupTopSubviews()
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
        
        self.infoLabelLeft = UILabel()
        infoLabelLeft.text = ""
        infoLabelLeft.textColor = UIColor.whiteColor()
        self.addSubview(infoLabelLeft)

        self.infoLabelRight = UILabel()
        infoLabelRight.text = ""
        infoLabelRight.textColor = UIColor.whiteColor()
        self.addSubview(infoLabelRight)
        
        self.infoLabelCenter = UILabel()
        infoLabelCenter.text = ""
        infoLabelCenter.textColor = UIColor.whiteColor()
        self.addSubview(infoLabelCenter)
        
    }
    

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        profile.centerX = self.centerX;
        profile.y = 80
        

    }

    
    func getUserImage(urlString:NSString) -> UIImage? {
        
        var arr = urlString.componentsSeparatedByString("/")
        
        let userId:NSString = arr[3] as! NSString
        
        let filePath = (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/"+(userId as String)+".jpg"
        
        let fm = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(filePath){
            
            let image = UIImage(contentsOfFile: filePath)
            return image
        }else{
            
                
            let imageUrl = NSURL(string: urlString as String)
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
        let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
        self.nameLabel.size = nameSize.size
        self.nameLabel.centerX = self.centerX
        self.nameLabel.y = CGRectGetMaxY(self.profile.frame) + 10
        
        
        self.infoLabelLeft.font = font.DreamStatusOrginalSourceFont
        let infoLeftString = "关注  " + (dealWithCount(userInfo.friends_count) as String)
         attr[NSFontAttributeName] = font.DreamStatusOrginalSourceFont
        let infoLeftSize = infoLeftString.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
        self.infoLabelLeft.size = infoLeftSize.size
        self.infoLabelLeft.text = infoLeftString
        
        self.infoLabelRight.font = font.DreamStatusOrginalSourceFont
        let infoRightString = "私信  " + (dealWithCount(userInfo.followers_count) as String)
        attr[NSFontAttributeName] = font.DreamStatusOrginalSourceFont
        let infoRightSize = infoRightString.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
        self.infoLabelRight.size = infoRightSize.size
        self.infoLabelRight.text = infoRightString
        
        self.infoLabelCenter.font = font.DreamStatusOrginalSourceFont
        let infoCenterString = "  |  "
        attr[NSFontAttributeName] = font.DreamStatusOrginalSourceFont
        let infoCenterSize = infoCenterString.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
        self.infoLabelCenter.size = infoCenterSize.size
        self.infoLabelCenter.text = infoCenterString
        
        self.infoLabelCenter.centerX = self.centerX
        self.infoLabelCenter.y = CGRectGetMaxY(self.nameLabel.frame) + 10
        
        self.infoLabelLeft.x = self.infoLabelCenter.centerX - self.infoLabelCenter.width / 2 - self.infoLabelLeft.width
        
        self.infoLabelLeft.y = self.infoLabelCenter.y
        
        self.infoLabelRight.x = self.infoLabelCenter.centerX + self.infoLabelCenter.width / 2
        self.infoLabelRight.y = self.infoLabelCenter.y

        
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
    
    
    
    func dealWithCount(count:Int32)->NSString{

        var title = ""
        
        if count>10000 {
            if count / 1000 % 10 == 0 {
                title = "\(count / 10000)万"
            }else{
                title = "\(count / 10000).\(count / 1000 % 10)万"
            }
            
        }else{
            title = "\(count)"
        }
        
       return title

        
    }
    
    
}
