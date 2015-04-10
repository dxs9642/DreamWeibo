//
//  DreamWebViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamWebViewController: UIViewController,UIWebViewDelegate{

    var webPage:UIWebView!
    var loadURL:NSString!
    var titleLabel:UILabel!
    var bottomView:UIView!
    var backButton:UIButton!
    var forwardButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        
        setupBottomControl()
        // Do any additional setup after loading the view.
    }
    
    func setupWebView(){
        webPage = UIWebView()
        webPage.frame = self.view.frame
        webPage.delegate = self
        self.view.addSubview(webPage)
        loadUrl()
    }
    
    
    func setupBottomControl(){
        bottomView = UIView()
        bottomView.x = 0
        bottomView.y = self.view.height - 44
        bottomView.height = 44
        bottomView.width = self.view.width
        bottomView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        self.view.addSubview(bottomView)
        
        backButton = setupButton("webPage_back",disableImageSource: "webPage_back_disable")
        backButton.x = 20
        backButton.addTarget(self, action: "backButtonPush", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.enabled = false
        
        forwardButton = setupButton("webPage_forward",disableImageSource: "webPage_forwars_disable")
        forwardButton.x = 70
        forwardButton.addTarget(self, action: "forwardButtonPush", forControlEvents: UIControlEvents.TouchUpInside)
        forwardButton.enabled = false
        
        let refreshButton = setupButton("webPage_refresh",disableImageSource: "webPage_refresh")
        refreshButton.x = bottomView.width - 20 - 38
        refreshButton.addTarget(self, action: "refreshButtonPush", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func backButtonPush(){
        if webPage.canGoBack {
            self.webPage.goBack()
        }
    }
    
    func forwardButtonPush(){
        if webPage.canGoForward {
            self.webPage.goForward()
        }
    }
    
    func refreshButtonPush(){
        self.webPage.reload()
    }
    
    
    func setupButton(imageSource:NSString,disableImageSource:NSString)->UIButton{
        let button = UIButton()
        let imageSize = CGSizeMake(38, 38)
        let image = UIImage(named: imageSource as String)!.imageByScalingToSize(imageSize)

        let disableImage = UIImage(named: disableImageSource as String)!.imageByScalingToSize(imageSize)

        button.setImage(image,forState: UIControlState.Normal)
        button.setImage(disableImage, forState: UIControlState.Disabled)
        button.y = 5
        button.size = imageSize
        bottomView.addSubview(button)
        return button
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if webPage.canGoBack {
            backButton.enabled = true
        }else{
            backButton.enabled = false
        }
        if webPage.canGoForward {
            forwardButton.enabled = true
        }else{
            forwardButton.enabled = false
        }

        
        //第二个是手机左上角那个齿轮的转动
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        titleLabel.text = webView.stringByEvaluatingJavaScriptFromString("document.title")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    func loadUrl(){
        titleLabel = UILabel()
        titleLabel.text = "正在加载。。。"
        titleLabel.font = UIFont.systemFontOfSize(13)
        let urlAddress = NSURL(string: loadURL as String)
        let urlRequest = NSURLRequest(URL: urlAddress!)
        webPage.loadRequest(urlRequest)
    }
    




}
