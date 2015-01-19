//
//  ComposeViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController,UITextViewDelegate,DreamComposeToolbarButtonProtocol {
    
    var textView:DreamTextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupTextView()
        setupToolbar()
    }
    
    func setupToolbar(){
        var toolbar = DreamComposeToolbar()
        toolbar.delegate = self
        toolbar.setWidth(self.view.width())
        toolbar.setHeight(44)
        self.textView?.inputAccessoryView = toolbar
        
    }
    
    func composeToolbarButtonClick(toolbar:DreamComposeToolbar,tag:Int){
        let type = DreamComposeToolbarButtonType()
        switch(tag){
        case type.Camera:
            print("Camera")
        case type.Emotion:
            print("Emotion")
        case type.Mention:
            print("Mention")
        case type.Picture:
            print("Picture")
        case type.Trend:
            print("Trend")
        default:
            print("null")
        }
    }
    
    
    
    
    func setupTitle(){
        self.title = "发微博"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Bordered, target: self, action:"cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Bordered
            , target: nil, action: "send")
        var textAttrs = NSMutableDictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
        
        textAttrs[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Disabled)
        self.navigationItem.rightBarButtonItem?.enabled = false
        //先写这里，右后用到
    }
    
    func setupTextView(){
        var textView = DreamTextView()
        self.textView = textView
        textView.delegate = self
        textView.frame = self.view.bounds
        textView.alwaysBounceVertical = true
        self.view.addSubview(textView)
        textView.becomeFirstResponder()
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func send(){
        
    }
    
    
    func textViewDidChange(textView: UITextView) {
        var textAttrs = NSMutableDictionary()
        
        if countElements(textView.text) != 0 {
            
            self.textView?.placehoderLabel.hidden = true
            
            textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
            
            textAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            self.textView?.placehoderLabel.hidden = false
            textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
            
            textAttrs[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        
    }
    
    
}
