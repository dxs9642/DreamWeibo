 //
//  DreamComposeToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/19/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit
 
protocol DreamComposeToolbarButtonProtocol{
    func composeToolbarButtonClick(toolbar:DreamComposeToolbar,tag:Int)
}
 
struct DreamComposeToolbarButtonType {
    
    let Camera = 301
    let Picture = 302
    let Mention = 303
    let Trend = 304
    let Emotion = 305
 }
 
 
class DreamComposeToolbar: UIView {

    var emotionButton:UIButton?
    
    var isEmotionButton = false

    override init() {
        super.init()
        self.backgroundColor = UIColor(patternImage: UIImage(named: "compose_toolbar_background_os7")!)
        
        self.addButtonWithIcon("compose_camerabutton_background_os7", highIcon: "compose_camerabutton_background_highlighted_os7", tag:type.Camera)
        self.addButtonWithIcon("compose_toolbar_picture_os7", highIcon: "compose_toolbar_picture_highlighted_os7", tag:type.Picture)
        self.addButtonWithIcon("compose_mentionbutton_background_os7", highIcon: "compose_mentionbutton_background_highlighted_os7", tag: type.Mention)
        self.addButtonWithIcon("compose_trendbutton_background_os7", highIcon: "compose_trendbutton_background_highlighted_os7",tag:type.Trend)
        self.emotionButton = self.addButtonWithIcon("compose_emoticonbutton_background_os7", highIcon: "compose_emoticonbutton_background_highlighted_os7", tag:type.Emotion)
        

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func setEmotionButton(isEmotionButton:Bool){
        
        if isEmotionButton {
            self.emotionButton!.setImage(UIImage(named: "compose_emoticonbutton_background_os7"), forState: UIControlState.Normal)
            self.emotionButton!.setImage(UIImage(named: "compose_emoticonbutton_background_highlighted_os7"), forState: UIControlState.Highlighted)

        }else{

            self.emotionButton!.setImage(UIImage(named: "compose_keyboardbutton_background"), forState: UIControlState.Normal)
            self.emotionButton!.setImage(UIImage(named: "compose_keyboardbutton_background_highlighted"), forState: UIControlState.Highlighted)
            
        }
        
        
    }
    
    
    let type = DreamComposeToolbarButtonType()

    var delegate:DreamComposeToolbarButtonProtocol?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let count = 5
        
        
        let buttonW = self.width()/CGFloat(Float(count))
        let buttonH = self.height()
        
        for i in 0...count-1 {
            var button = self.subviews[i] as UIButton
            button.frame = CGRectMake(CGFloat(Float(i))*buttonW, 0, buttonW, buttonH)
        }
        
    }

    
    func addButtonWithIcon(icon:String,highIcon:NSString,tag:Int) -> UIButton{
        var button = UIButton()
        button.tag = tag
        button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: icon), forState: UIControlState.Normal)
        button.setImage(UIImage(named: highIcon), forState: UIControlState.Highlighted)
        self.addSubview(button)
        return button
    }
    
    func buttonClick(button:UIButton){
        self.delegate?.composeToolbarButtonClick(self, tag: button.tag)
    }
    
}
