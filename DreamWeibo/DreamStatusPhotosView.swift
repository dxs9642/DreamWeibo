//
//  DreamStatusPhotosView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusPhotosView: UIView {

    var pic_urls:NSArray?
    var imageView:UIImageView?
    var lastFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        for var i=0; i<9; i++ {
            var photoView = DreamStatusPhotoView()
            var recognizer = UITapGestureRecognizer()
            recognizer.addTarget(self, action: "tapPhoto:")
            self.addSubview(photoView)
            photoView.addGestureRecognizer(recognizer)
        }
    }
    
    
    func tapPhoto(recognizer:UITapGestureRecognizer){

        var cover = UIView()
        cover.frame = UIScreen.mainScreen().bounds
        cover.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        UIApplication.sharedApplication().keyWindow?.addSubview(cover)
        
        var imageView = UIImageView()
        self.imageView = imageView
        var photoView = recognizer.view as DreamStatusPhotoView
        
        let imageStr = photoView.photo?.bmiddle_pic
        imageView.setImageWithURL(NSURL(string: imageStr!))
        imageView.frame = self.convertRect(photoView.frame, toView: cover)
        lastFrame = imageView.frame
        cover.addSubview(imageView)
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            imageView.setWidth(cover.width())
            imageView.setHeight(photoView.image!.size.height * imageView.width() / photoView.image!.size.width)
            imageView.center = cover.center
            
        })
        var recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: "tapCover:")
        cover.addGestureRecognizer(recognizer)
    }

  
    func tapCover(recognizer:UITapGestureRecognizer){
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            

            
        })
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.imageView!.frame = self.lastFrame
            recognizer.view?.backgroundColor = UIColor.clearColor()
            
            }) { (finished:Bool) -> Void in
                
            recognizer.view!.removeFromSuperview()
            self.imageView = nil
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count = self.pic_urls?.count
        for var i=0;i<count;i++ {
            var photoView = self.subviews[i] as DreamStatusPhotoView
            photoView.setWidth(70)
            photoView.setHeight(70)
            let maxCols = count==4 ? 2 : 3
            let x = CGFloat(Float(i % maxCols * (70+10)))
            let y = CGFloat(Float(i / maxCols * (70+10)))
            photoView.frame.origin = CGPointMake(x, y)

        }
    }
    

    
    func setupPic_urls(pic_urls:NSArray){
        self.pic_urls = pic_urls

        for var i=0;i<pic_urls.count;i++ {
            var photoView = self.subviews[i] as DreamStatusPhotoView
            photoView.setupPhoto(pic_urls[i] as DreamPhoto)
            photoView.hidden = false
        }
        for var i=pic_urls.count;i<9;i++ {
            var photoView = self.subviews[i] as DreamStatusPhotoView
            photoView.hidden = true
        }

    }
    
}
