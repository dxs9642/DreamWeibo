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
    
    func setupPhoto(photo:DreamPhoto){
        self.photo = photo
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.clipsToBounds = true
        self.setImageWithURL(NSURL(string: photo.thumbnail_pic), placeholderImage: UIImage(named: "timeline_image_placeholder"))
        
    }
    
}
