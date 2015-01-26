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
    var isChangingKeyboard = false
    lazy var keyboard = DreamEmotionKeyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTextView()
        setupToolbar()
        setupPhotosView()
        
        keyboard.setHeight(216)
        keyboard.setWidth(UIScreen.mainScreen().bounds.width)
        
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
        
        self.isChangingKeyboard = true
        
        if self.textView?.inputView == nil {

            self.textView?.inputView = self.keyboard
            self.toolbar?.setEmotionButton(false)
        }else{
            self.textView?.inputView = nil
            self.toolbar?.setEmotionButton(true)
            
        }
        

        
        self.textView!.resignFirstResponder()
        
        let delayInSeconds:Int64 =  100000000  * 1
        var time:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
        
            let a = self.textView!.becomeFirstResponder()

        }
        

        
    
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
            , target: self, action: "send")
        var textAttrs = NSMutableDictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
        
        textAttrs[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttrs, forState: UIControlState.Disabled)

        if(textView != nil && !textView!.text.isEmpty ){
            self.navigationItem.rightBarButtonItem?.enabled = true

        }else{
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
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
        
        if isChangingKeyboard {
            self.isChangingKeyboard = false
            return
        }
        
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
        
        let imgs = photosView?.images()
        
        if  imgs?.count == 0 {
            sendStatusWithoutImage()
        }else{
            sendStatusWithImage(imgs!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    func sendStatusWithoutImage(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        params["status"] = textView!.text
        
        DreamHttpTool.post("https://api.weibo.com/2/statuses/update.json", params: params, success: { (obj:AnyObject!) -> Void in
            MBProgressHUD.showSuccess("发送成功")
            
            //            let result = obj as NSDictionary
            //
            //
            //            let statusDictArray = result["statuses"] as NSArray
            //
            //
            //            let newStatus = NSMutableArray( array: DreamStatus.objectArrayWithKeyValuesArray(statusDictArray))
            //
            //
            //            if newStatus.count != 0 {
            //                let range = NSMakeRange(0, newStatus.count)
            //                self.statuses.insertObjects(newStatus, atIndexes:NSIndexSet(indexesInRange:range))
            //                self.tableView.reloadData()
            //            }
            //            self.showStatusCount(newStatus.count)
            //            self.refreshControl?.endRefreshing()
            

        }) { () -> Void in
            MBProgressHUD.showSuccess("发送失败")

        }
        
     
    }
    
    func sendStatusWithImage(images:NSArray){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        var mgr = AFHTTPRequestOperationManager()
        
        var params = NSMutableDictionary()
        
        params["access_token"] = account!.access_token
        
        params["status"] = textView!.text
        
        mgr.POST("https://api.weibo.com/2/statuses/upload.json", parameters: params, constructingBodyWithBlock: { (formData:AFMultipartFormData!) -> Void in
            

            
            let image = images.lastObject as UIImage
            
            let data = UIImageJPEGRepresentation(image, 1.0)
            
            
            formData.appendPartWithFileData(data, name: "pic", fileName: "status.jpg", mimeType: "image/jpeg")
            
            
            
            }, success: { (operation:AFHTTPRequestOperation! , obj:AnyObject!) -> Void in
                
                
                MBProgressHUD.showSuccess("发送成功")
                self.dismissViewControllerAnimated(true, completion: nil)

                
                //            let result = obj as NSDictionary
                //
                //
                //            let statusDictArray = result["statuses"] as NSArray
                //
                //
                //            let newStatus = NSMutableArray( array: DreamStatus.objectArrayWithKeyValuesArray(statusDictArray))
                //
                //
                //            if newStatus.count != 0 {
                //                let range = NSMakeRange(0, newStatus.count)
                //                self.statuses.insertObjects(newStatus, atIndexes:NSIndexSet(indexesInRange:range))
                //                self.tableView.reloadData()
                //            }
                //            self.showStatusCount(newStatus.count)
                //            self.refreshControl?.endRefreshing()
                
                
                
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                MBProgressHUD.showSuccess("发送失败")
                self.dismissViewControllerAnimated(true, completion: nil)

                
        }
        
        
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
