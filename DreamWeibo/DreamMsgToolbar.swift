//
//  DreamMsgToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamMsgToolbar: UIImageView,UITextViewDelegate {

    let voiceButton = UIButton()
    let textContent = DreamTextView()
    let emotionButton = UIButton()
    let addButton = UIButton()
    var textChange = false
    var textHeight:CGFloat = 0
    
    
     override init() {
        super.init()
        
        self.userInteractionEnabled = true

        
        voiceButton.setBackgroundImage(UIImage(named: "message_voice_background"), forState: UIControlState.Normal)
        voiceButton.setBackgroundImage(UIImage(named: "message_voice_background_highlighted"), forState: UIControlState.Highlighted)
        self.addSubview(voiceButton)
        
        emotionButton.setBackgroundImage(UIImage(named: "message_emotion_background"), forState: UIControlState.Normal)
        emotionButton.setBackgroundImage(UIImage(named: "message_emotion_background_highlighted"), forState: UIControlState.Highlighted)
        self.addSubview(emotionButton)
        
        addButton.setBackgroundImage(UIImage(named: "message_add_background"), forState: UIControlState.Normal)
        addButton.setBackgroundImage(UIImage(named: "message_add_background_highlighted"), forState: UIControlState.Highlighted)
        self.addSubview(addButton)
        
        textContent.scrollEnabled = false
        textContent.alwaysBounceVertical = true
        textContent.delegate = self
        
        self.addSubview(textContent)
        
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let buttonWidth:CGFloat = 30
        
        voiceButton.x = 0
        voiceButton.y = self.height - buttonWidth - 5
        voiceButton.height = buttonWidth
        voiceButton.width = buttonWidth
        
        addButton.x = self.width - buttonWidth
        addButton.y =  self.height - buttonWidth - 5
        addButton.height = buttonWidth
        addButton.width = buttonWidth
        
        
        emotionButton.x = addButton.x - buttonWidth
        emotionButton.y =  self.height - buttonWidth - 5
        emotionButton.height =  buttonWidth
        emotionButton.width = buttonWidth
        
        if !textChange {
            textContent.x = CGRectGetMaxX(voiceButton.frame) + 5
            textContent.y =  4
            textContent.width = self.width - buttonWidth * 3 - 5
            textContent.height = self.height - 8
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        
        if textView.hasText() {
            
            textContent.placehoderLabel.hidden = true
            
        }else{
            textContent.placehoderLabel.hidden = false
        }
        let text = textView.text;
        
        let boundingSize = CGSizeMake(textView.width - 47.24, CGFloat.max)
        let font = DreamFont()
        var attr = NSMutableDictionary()
        attr[NSFontAttributeName] = font.DreamStatusOrginalSourceFont
        let textSize = text.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
        
        if !textChange {
            textChange = true
            textHeight = textSize.height
        }
        
        if(textHeight < textSize.height){
            
            let distance = textSize.height - textHeight + 3.1
            
            textView.height += distance
            self.y -= distance
            self.height += distance
            
            textHeight = textSize.height
        }else if(textHeight > textSize.height){
            let distance = textHeight - textSize.height  + 3.1

            textView.height -= distance
            self.y += distance
            self.height -= distance
            textHeight = textSize.height
        }
        
    
    }

}
