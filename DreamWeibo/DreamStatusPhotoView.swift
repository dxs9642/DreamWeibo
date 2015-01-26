//
//  DreamStatusPhotoView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusPhotoView: UIImageView {

    var photo:DreamPhoto?
    var gifView:UIImageView?
    
    override init() {
        super.init()
        self.userInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.clipsToBounds = true
        
        gifView = UIImageView(image: UIImage(named: "timeline_image_gif"))
        self.addSubview(gifView!)

    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let x = self.width() - self.gifView!.width()
        let y = self.height() - self.gifView!.height()
        
        gifView!.frame.origin = CGPointMake(x, y)
        
    }
    
    func setupPhoto(photo:DreamPhoto){
        self.photo = photo
        self.setImageWithURL(NSURL(string: photo.thumbnail_pic), placeholderImage: UIImage(named: "timeline_image_placeholder"))
        if photo.thumbnail_pic.pathExtension.lowercaseString == "gif" {
            self.gifView?.hidden = false
        }else{
            self.gifView?.hidden = true
        }
        
    
    }
    
}
