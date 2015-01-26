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
            photoView.tag = i
            photoView.addGestureRecognizer(recognizer)
        }
    }
    
    
    func tapPhoto(recognizer:UITapGestureRecognizer){

        var browser = MJPhotoBrowser()
        
        var photos = NSMutableArray()
        
        let count = self.pic_urls!.count
        
        for var i=0;i<count;i++ {
            
            var pic = pic_urls![i] as DreamPhoto
            var photo = MJPhoto()
            photo.url = NSURL(string: pic.bmiddle_pic)
            photo.srcImageView = self.subviews[i] as UIImageView
            
            photos.addObject(photo)
        }
        
        
        browser.photos = photos
        
        
        browser.currentPhotoIndex = UInt(recognizer.view!.tag)
        
        browser.show()
        
        
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
