//
//  OauthViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class OauthViewController: UIViewController,UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var webView = UIWebView()
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=65654089&redirect_uri=http://www.dream.net")
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.URL.absoluteString! as NSString
        
        
        let range = url.rangeOfString("http://www.dream.net/?code=")
        print(url)
        if range.length != 0 {
            let start = range.length
            let code = url.substringFromIndex(start)
            accessTokenWithCode(code)
            return false
        }
        
        return true
        
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        MBProgressHUD.showMessage("正在加载")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideHUD()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        MBProgressHUD.hideHUD()
    }
    
    func accessTokenWithCode(code:NSString){
        
        
        
        
    }
    
    
    
}
