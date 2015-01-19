//
//  UIView+Extension.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/16/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

extension UIView{
    
    func width()->CGFloat{
        return self.frame.size.width
    }
    
    func height()->CGFloat{
        return self.frame.size.height
    }
    
    func setHeight(height:CGFloat){

        self.frame.size.height = height

    }
    
    func setWidth(width:CGFloat){
        self.frame.size.width = width
    }
    
    func size()->CGSize{
        return self.frame.size
    }
    
    func setSize(size:CGSize){
        self.frame.size = size
    }
    
    
}
