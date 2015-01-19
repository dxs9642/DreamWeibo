//
//  DreamTextView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/19/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamTextView: UITextView {
    
    let placehoder:NSString = "请输入文字"
    var placehoderLabel = UILabel()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        placehoderLabel.numberOfLines = 0
        placehoderLabel.backgroundColor = UIColor.clearColor()
        placehoderLabel.textColor = UIColor.lightGrayColor()
        self.font = UIFont.systemFontOfSize(14)
        placehoderLabel.font = self.font
        self.addSubview(placehoderLabel)
        
        self.placehoderLabel.frame = CGRectMake(5, 8, self.width()-2*5, 100)
        self.placehoderLabel.text = placehoder
        
        let maximumLabelSize = CGSizeMake(self.placehoderLabel.width(), CGFloat(MAXFLOAT))
        
        var option = NSStringDrawingOptions.UsesLineFragmentOrigin
        var attr = NSMutableDictionary()
        attr[NSFontAttributeName] = self.placehoderLabel.font
        let rect =  self.placehoder.boundingRectWithSize(maximumLabelSize, options: option, attributes: attr, context: nil)
        self.placehoderLabel.setHeight(rect.size.height)
        
        
    }

}
