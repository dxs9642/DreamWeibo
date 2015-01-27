//
//  DreamEmotionGridView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/27/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamEmotionGridView: UIView {

    var emotions:NSArray?
    var deleteButton:UIButton?
    var emotionViews:NSMutableArray?
    
    override init() {
        super.init()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        deleteButton = UIButton()
        deleteButton?.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
        deleteButton?.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
        self.addSubview(deleteButton!)
        emotionViews = NSMutableArray()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setEmotions(emotions:NSArray){
        self.emotions = emotions
        let count = emotions.count
        
        let currentButtonNum = self.subviews.count - 1
        
        for var i=0;i<count;i++ {
            var emotionView:UIButton!
            if i>currentButtonNum-1 {
                emotionView = UIButton()
                self.addSubview(emotionView)
                emotionViews?.addObject(emotionView)
            }else{
                emotionView = emotionViews![i] as? UIButton
            }
            emotionView.hidden = false
            emotionView.adjustsImageWhenHighlighted = false
            let emotion = emotions[i] as DreamEmotion
            if emotion.code == nil {
                let icon = "\(emotion.directory)\(emotion.png)"
                emotionView.setImage(UIImage(named:icon), forState: UIControlState.Normal)
                emotionView.setTitle(nil, forState: UIControlState.Normal)
            }else{
                emotionView.setImage(nil, forState: UIControlState.Normal)
                emotionView.setTitle(emotion.emoji, forState: UIControlState.Normal)
                emotionView.titleLabel?.font = UIFont.systemFontOfSize(32)
            }
            
        }
        
        for var i=count;i<currentButtonNum;i++ {
            (emotionViews![i] as? UIButton)?.hidden = true
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftInset:CGFloat = 15
        let topInset:CGFloat = 15
        
        let count = self.emotions?.count
        let properties = DreamEmotionProperty()
        
        let emotionViewW = ( self.width() - CGFloat(Float(2 * leftInset)) ) / CGFloat(Float(properties.maxCols))
        let emotionViewH = ( self.height() - CGFloat(Float(topInset)) ) / CGFloat(Float(properties.maxRows))
        
        for var i=0;i<count;i++ {
            let button = emotionViews![i] as UIButton
            let x = leftInset + CGFloat(Float(i % properties.maxCols)) * emotionViewW
            let y = topInset + CGFloat(Float(i / properties.maxCols)) * emotionViewH
            button.frame = CGRectMake(x, y, emotionViewW, emotionViewH)
        }
        
        let i = properties.maxCountPerPage
        let x = leftInset + CGFloat(Float(i % properties.maxCols)) * emotionViewW
        let y = topInset + CGFloat(Float(i / properties.maxCols)) * emotionViewH
        self.deleteButton?.frame = CGRectMake(x, y, emotionViewW, emotionViewH)
        
    }
    
}
