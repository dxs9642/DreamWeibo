//
//  DreamMsgToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

protocol MsgToolbarButtonClickProtocol{
    func msgToolbarButtonClick(tag:Int)
    func sendMessage()
}

struct MsgToolbarButtonType{
    let voice = 1001
    let emotion = 1002
    let add = 1003
}

class DreamMsgToolbar: UIImageView,UITextViewDelegate {

    let voiceButton = UIButton()
    let textContent = DreamTextView()
    let emotionButton = UIButton()
    let addButton = UIButton()
    var textChange = false
    var textHeight:CGFloat = 0
    var delegate:MsgToolbarButtonClickProtocol?

    
    convenience init(){
        let frame = CGRectMake(0, 0, 0, 0)
        self.init(frame:frame)
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        let type = MsgToolbarButtonType()
        
        voiceButton.setBackgroundImage(UIImage(named: "message_voice_background"), forState: UIControlState.Normal)
        voiceButton.setBackgroundImage(UIImage(named: "message_voice_background_highlighted"), forState: UIControlState.Highlighted)
        voiceButton.tag = type.voice
        voiceButton.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(voiceButton)
        
        emotionButton.setImage(UIImage(named: "message_emotion_background"), forState: UIControlState.Normal)
        emotionButton.setImage(UIImage(named: "message_emotion_background_highlighted"), forState: UIControlState.Highlighted)
        emotionButton.tag = type.emotion
        emotionButton.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(emotionButton)
        
        addButton.setBackgroundImage(UIImage(named: "message_add_background"), forState: UIControlState.Normal)
        addButton.setBackgroundImage(UIImage(named: "message_add_background_highlighted"), forState: UIControlState.Highlighted)
        addButton.tag = type.add
        addButton.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(addButton)
        
        textContent.scrollEnabled = false
        textContent.alwaysBounceVertical = true
        textContent.delegate = self
        textContent.returnKeyType = UIReturnKeyType.Send
        textContent.delegate = self
        self.addSubview(textContent)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emotionDidSelect:", name: "DreamEmotionDidSelectedNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emotionDidDeleted:", name: "DreamEmotionDidDeletedNotification", object: nil)
        
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
        let text = textView.attributedText;
        
        let boundingSize = CGSizeMake(textView.width - 10, CGFloat.max)
        let font = DreamFont()
        let textSize = text.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)

        
        if !textChange {
            textChange = true
            textHeight = textSize.height
        }
        
        if(textHeight < textSize.height){
            
            let distance = textSize.height - textHeight + 0.8
            
            textView.height += distance
            self.y -= distance
            self.height += distance
            
            textHeight = textSize.height
        }else if(textHeight > textSize.height){
            let distance = textHeight - textSize.height  + 0.8

            textView.height -= distance
            self.y += distance
            self.height -= distance
            textHeight = textSize.height
        }
        
    
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text=="\n" {
            self.delegate?.sendMessage()
            return false
        }
        return true
    }
    
    func buttonClick(button:UIButton){
        self.delegate?.msgToolbarButtonClick(button.tag)
    }

    
    func setTheEmotionButton(isEmotionButton:Bool){
        
        if isEmotionButton {
            self.emotionButton.setImage(UIImage(named: "message_emotion_background"), forState: UIControlState.Normal)
            self.emotionButton.setImage(UIImage(named: "message_emotion_background_highlighted"), forState: UIControlState.Highlighted)
            
        }else{
            
            self.emotionButton.setImage(UIImage(named: "message_keyboard_background"), forState: UIControlState.Normal)
            self.emotionButton.setImage(UIImage(named: "message_keyboard_background_highlighted"), forState: UIControlState.Highlighted)
            
        }
    }
    
    func emotionDidDeleted(note:NSNotification){
        
        self.textContent.deleteBackward()
    }
    
    func emotionDidSelect(note:NSNotification){
        let emotion = note.userInfo!["emotion"] as! DreamEmotion
        
        self.textContent.appendEmotion(emotion)
        
        self.textViewDidChange(self.textContent)
        
        
    }
    
    func finishChange(){
        self.textHeight = 0
        self.textChange = false
        self.height = 40
        self.textContent.height = self.height - 8
        self.textContent.text = ""
        self.y = self.superview!.height - self.height
    }
    
    
}
