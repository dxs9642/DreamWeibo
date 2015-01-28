//
//  DreamComposePhotosView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/19/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit


class DreamComposePhotosView: UIView {

    func addImage(image:UIImage){
        
        var imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count
        
        
        let maxColsPerRow = 4
        let margin:CGFloat = 10
        
        let imageViewW = (self.width() - margin * CGFloat(Float(count + 1))) / CGFloat(Float(maxColsPerRow))
        let imageViewH = imageViewW
        var i = 0
        for i=0 ; i<count ; i++ {
            let row = CGFloat(Float(i / maxColsPerRow))
            
            let col = CGFloat(Float(i % maxColsPerRow))
            
            var imageView = self.subviews[i] as UIImageView
            
            imageView.frame = CGRectMake(margin+(imageViewW+margin)*col, (imageViewW+margin)*row, imageViewW, imageViewH)
            
        }
        
    }
    
    func images() -> NSArray {
        let arr = NSMutableArray()
        for img in self.subviews {
            let imageView = img as UIImageView
            arr.addObject(imageView.image!)
        }
        return NSArray(array: arr)
    }
    

}
