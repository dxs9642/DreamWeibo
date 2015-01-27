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
    var deleteButton:DreamEmotionView?
    var emotionViews:NSMutableArray?
    var popView = DreamEmotionPopView.popView()
    
    override init() {
        super.init()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        deleteButton = DreamEmotionView()
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
            var emotionView:DreamEmotionView!
            if i>currentButtonNum-1 {
                emotionView = DreamEmotionView()
                self.addSubview(emotionView)
                emotionViews?.addObject(emotionView)
                emotionView.addTarget(self, action: "emotionClick:", forControlEvents: UIControlEvents.TouchUpInside)
                emotionView.hidden = false

            }else{
                emotionView = emotionViews![i] as? DreamEmotionView
            }
            emotionView.adjustsImageWhenHighlighted = false
            let emotion = emotions[i] as DreamEmotion
            emotionView.setEmotion(emotion)
            
        }
        
        for var i=count;i<currentButtonNum;i++ {
            (emotionViews![i] as? DreamEmotionView)?.hidden = true
        }
    }
    
    func emotionClick(emotionView:DreamEmotionView){
        
        popView.showFromeEmotionView(emotionView)
        

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( 0.25 * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
            self.popView.dismiss()
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
            let button = emotionViews![i] as DreamEmotionView
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
