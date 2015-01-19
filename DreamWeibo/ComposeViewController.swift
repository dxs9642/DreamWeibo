//
//  ComposeViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController,UITextViewDelegate,DreamComposeToolbarButtonProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var textView:DreamTextView?
    var toolbar:DreamComposeToolbar?
    var photosView:DreamComposePhotosView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTextView()
        setupToolbar()
        setupPhotosView()

        
    }
    
    func setupPhotosView(){
        var photosView = DreamComposePhotosView()
        self.photosView = photosView

        photosView.frame = CGRectMake(0, 100, self.view.width(), self.view.height())
        
        self.textView?.addSubview(photosView)
        
        
    }
    
    func setupToolbar(){
        var toolbar = DreamComposeToolbar()
        self.toolbar = toolbar
        toolbar.delegate = self
        toolbar.setWidth(self.view.width())
        toolbar.setHeight(44)
//        self.textView?.inputAccessoryView = toolbar
        toolbar.frame.origin.y = self.view.height() - toolbar.height()
        self.view.addSubview(toolbar)
        
        
    }
    
    func composeToolbarButtonClick(toolbar:DreamComposeToolbar,tag:Int){
        let type = DreamComposeToolbarButtonType()
        switch(tag){
        case type.Camera:
            openCamera()
        case type.Emotion:
            openEmotion()
        case type.Mention:
            print("Mention")
        case type.Picture:
            openPicture()
        case type.Trend:
            print("Trend")
        default:
            print("null")
        }
    }
    
    
    func openCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)==false{
            return
        }
        
        var ipc = UIImagePickerController()
        ipc.sourceType = UIImagePickerControllerSourceType.Camera
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
        
    }
    
    func openEmotion(){
        
    }
    
    func openPicture(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)==false{
            return
        }
        
        var ipc = UIImagePickerController()
        ipc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: "UIKeyboardWillHideNotification", object: nil)
    }
    
    func keyBoardWillShow(note:NSNotification){

        
        let dic = note.userInfo!

        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as Double
        
        UIView.animateWithDuration(duration, animations: { () -> Void in

            let keyboardF = (dic[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
            let keyboardH = keyboardF.size.height
            
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH)
            
            
        })        
        
    }
    
    func keyboardWillHide(note:NSNotification){
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as Double
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.toolbar!.transform = CGAffineTransformIdentity;
            
        })
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
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.photosView?.addImage(image)
        
    }
    
    
}
