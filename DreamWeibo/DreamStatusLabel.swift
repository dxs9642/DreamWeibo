//
//  DreamStatusLabel.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/29/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusLabel: UIView {


    var attributedText:NSAttributedString!{
        didSet{
            self.textView.attributedText = attributedText
        }
    }
    var textView:UITextView!
    
    var links:NSMutableArray!{

        get{
           
            var links = NSMutableArray()
            self.attributedText.enumerateAttributesInRange(NSMakeRange(0, self.attributedText.length), options: NSAttributedStringEnumerationOptions.allZeros) { (obj, range, stop) -> Void in
                
                let attrs = obj as NSDictionary
                
                let linkText = attrs["DreamLinkText"] as? NSString
                
                if linkText == nil {
                    return
                }
                
                let link = DreamLink()
                link.text = linkText
                link.range = range
                
                let rects = NSMutableArray()
                
                
                self.textView.selectedRange = range
                
                let selectionRects = self.textView.selectionRectsForRange(self.textView.selectedTextRange!)
                for selectionRect in selectionRects {
                    let rect = selectionRect as UITextSelectionRect
                        if rect.rect.size.width == 0 || rect.rect.size.height == 0 {
                            continue
                        }
                    rects.addObject(selectionRect)
                }
                link.rects = rects
                links.addObject(link)
            }
            return links
        }

    }
    
    override init() {

        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView = UITextView()
        textView.scrollEnabled = false
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5)
        textView.editable = false
        textView.backgroundColor = UIColor.clearColor()
        textView.userInteractionEnabled = false
        
        self.addSubview(textView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView?.frame = self.bounds
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject? = touches.anyObject()
        let point = touch?.locationInView(touch?.view)
        
        
        let touchLink = touchLinkWithPoint(point!)
        
        showLinkBackground(touchLink)

    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
    }

    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject? = touches.anyObject()
        let point = touch?.locationInView(touch?.view)
        
        
        let touchLink = touchLinkWithPoint(point!)
        
        if touchLink != nil {
            let dic = NSMutableDictionary()
            dic["DreamLinkText"] = touchLink?.text
            NSNotificationCenter.defaultCenter().postNotificationName("DreamDidSelectTextNotionfication", object: nil, userInfo: dic)
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( 0.25 * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
            self.removeAllLinkBackground()
        }
        
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( 0.25 * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
            self.removeAllLinkBackground()
        }
    }
    
    func touchLinkWithPoint(point:CGPoint)->DreamLink?{
        
        var touchLink:DreamLink?
        self.links.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
            let link = obj as DreamLink
            for selectionRect in link.rects {
                
                let rect = selectionRect as UITextSelectionRect
                
                if CGRectContainsPoint(rect.rect,point) {
                    touchLink = link
                    break
                }
            }
        }
        return touchLink
    }
    
    func showLinkBackground(touchLink:DreamLink?){
        
        if touchLink != nil {
            for selection in touchLink!.rects {
                let selectRect = selection as UITextSelectionRect
                let bg = UIView()
                bg.tag = 100000
                bg.layer.cornerRadius = 3
                bg.frame = selectRect.rect

                bg.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.5)
                self.textView.addSubview(bg)
            }
            
        }
        
    }
    
    func removeAllLinkBackground(){
        for view in self.textView.subviews {
            if view.tag == 100000{
                view.removeFromSuperview()
            }
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if (self.touchLinkWithPoint(point) != nil){
            return self
        }
        return nil
    }
    
}
