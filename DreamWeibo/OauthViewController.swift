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
        let appInfo = AppInfo()
        super.viewDidLoad()
        var webView = UIWebView()
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(appInfo.appKey)&redirect_uri=\(appInfo.redirectUrl)")
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.URL.absoluteString! as NSString
        
        
        let range = url.rangeOfString("http://www.dream.net/?code=")
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
        
        let appInfo = AppInfo()
        
        var mgr = AFHTTPRequestOperationManager()
        
        var params = NSMutableDictionary()
        params["client_id"] = appInfo.appKey
        params["client_secret"] = appInfo.appSecret
        params["grant_type"] = "authorization_code"
        params["code"] = code
        params["redirect_uri"] = appInfo.redirectUrl
        //我哩个去，就错了一个地方。。。。。http://www.dream.net多加了最后的反斜线就错了
        
        mgr.POST("https://api.weibo.com/oauth2/access_token", parameters: params, success: { (operation:AFHTTPRequestOperation! , obj:AnyObject!) -> Void in
            
            
            let result = obj as NSDictionary
            
            let account = Account()
            account.setWithDictionary(result)
            
            Account.save(account)
                        
            MBProgressHUD.hideHUD()
            
            var defaults = NSUserDefaults()
            defaults.setValue("true", forKey: "accessToken")
            defaults.synchronize()
            
            var window = UIApplication.sharedApplication().keyWindow
            window?.rootViewController = WeiboTabBarViewController()
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                MBProgressHUD.hideHUD()
        }
        
    }
    
    
    
}
