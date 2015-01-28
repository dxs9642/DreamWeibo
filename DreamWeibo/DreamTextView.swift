//
//  DreamTextView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/19/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamTextView: UITextView {
    
    
    let placehoder:NSString!
    var placehoderLabel:UILabel!

    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        placehoder = "请输入文字"
        placehoderLabel = UILabel()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    



    
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
    
    
    
    func appendEmotion(emotion:DreamEmotion){
        

        
        if emotion.emoji == nil {
            
            let attributedText =  NSMutableAttributedString(attributedString: self.attributedText)

            
            
            var attach = DreamEmotionAttachment()
            attach.emotion = emotion
            let height = self.font.lineHeight
            attach.bounds = CGRectMake(0, -5 , height, height)
            let attachString = NSAttributedString(attachment: attach)
            
            
            let insertIndex = self.selectedRange.location
            attributedText.insertAttributedString(attachString, atIndex: insertIndex)
            
            attributedText.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0,attributedText.length))
            self.attributedText = attributedText
            self.selectedRange = NSMakeRange(insertIndex+1, 0)
            
        }else{

            self.insertText(emotion.emoji)
        }
        


    }
    
    func realText()->NSString{
        
        var string = NSMutableString()
        self.attributedText.enumerateAttributesInRange(NSMakeRange(0, self.attributedText.length), options: NSAttributedStringEnumerationOptions.allZeros) { (attrs, range, stop) -> Void in
            
            let dic = attrs as NSDictionary
            let attach = attrs["NSAttachment"] as? DreamEmotionAttachment
            if attach == nil {
                string.appendString(self.attributedText.attributedSubstringFromRange(range).string)
            }else{
                string.appendString(attach!.emotion.chs)
            }
            
        }
        return string
        
    }
    



}
