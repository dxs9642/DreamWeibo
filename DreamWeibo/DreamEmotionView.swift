//
//  DreamEmotionView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/27/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamEmotionView: UIButton {
   
    var emotion:DreamEmotion?
    
    
    
    func setEmotion(emotion:DreamEmotion){
        self.emotion = emotion
        if emotion.code == nil {
            let icon = "\(emotion.directory)\(emotion.png)"
            var image = UIImage(named:icon)
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.setImage(image, forState: UIControlState.Normal)
            self.setTitle(nil, forState: UIControlState.Normal)
        }else{
            UIView.setAnimationsEnabled(false)
            self.setImage(nil, forState: UIControlState.Normal)
            self.setTitle(emotion.emoji, forState: UIControlState.Normal)
            self.titleLabel?.font = UIFont.systemFontOfSize(32)
            UIView.setAnimationsEnabled(true)
        }
    }
    
}
