//
//  UIImage+Extension.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/16/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

extension UIImage{
    class func resizeImage(name:NSString) ->UIImage {
        var image = UIImage(named: name)
        
        
        return image!.stretchableImageWithLeftCapWidth(Int(Float(image!.size.width*0.5)) , topCapHeight:Int(Float(image!.size.height*0.5)))
        

        
        
        
    }
}