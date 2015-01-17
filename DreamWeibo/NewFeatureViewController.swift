//
//  NewFeatureViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class NewFeatureViewController: UIViewController,UIScrollViewDelegate{

    var imageCount = 5
    var pageControl:UIPageControl?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupScrollView()
        setupPageControl()
    }
    
    func setupPageControl(){
        var pageControl = UIPageControl()
        self.pageControl = pageControl
        pageControl.numberOfPages = imageCount
        pageControl.center = CGPointMake(self.view.width()*0.5, self.view.height()-CGFloat(Float(30)))
        pageControl.currentPageIndicatorTintColor = UIColor(red: 253/255, green: 98/255, blue: 43/255, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        self.view.addSubview(pageControl)
    }
    
    func setupScrollView(){
        var scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(self.view.width()*CGFloat(Float(imageCount)), self.view.height())
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        let imageW = scrollView.width()
        let imageH = scrollView.height()
        
        for i in 1...imageCount {
            let image = UIImage(named: "new_feature_\(i)")
            var imageView = UIImageView(image: image)
            imageView.userInteractionEnabled = true
            imageView.frame = CGRectMake(scrollView.width()*CGFloat(Float(i-1)), 0, scrollView.width(), scrollView.height())
            scrollView.addSubview(imageView)
            
            if i == imageCount {
                setupImageView(imageView)
            }
            
        }
        
    }
    
    func setupImageView(imageView:UIImageView){
        setupStartButton(imageView)
        setupShareButton(imageView)
    }
    
    func setupShareButton(imageView:UIImageView){
        var shareButton = UIButton()
        imageView.addSubview(shareButton)
        shareButton.setTitle("分享给大家", forState: UIControlState.Normal)
        shareButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        shareButton.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal)
        shareButton.setSize(CGSizeMake(150, 35))
        shareButton.center = CGPointMake(imageView.width()*0.5,imageView.height()*0.75 )
        shareButton.tag = 200
        shareButton.addTarget(self, action: "shareClick:", forControlEvents: UIControlEvents.TouchUpInside)

 
        
    }
    
    func shareClick(sender:UIButton){
        if sender.tag == 200 {
            sender.setImage(UIImage(named: "new_feature_share_true"), forState: UIControlState.Normal)
            sender.tag = 201
        }else{
            sender.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal)
            sender.tag = 200
        }
    }
    
    func setupStartButton(imageView:UIImageView){
        var startButton = UIButton()
        imageView.addSubview(startButton)
        startButton.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        startButton.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        startButton.setSize(startButton.currentBackgroundImage!.size)
        startButton.center = CGPointMake(imageView.width()*0.5, imageView.height()*0.85)
        
        
        startButton.setTitle("马上体验", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startClick", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func startClick(){
        
        var window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = WeiboTabBarViewController()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentPage = Int(Float((scrollView.contentOffset.x+self.view.width()/2)/self.view.width()))
        self.pageControl?.currentPage = currentPage
        
    }
    
    
}
