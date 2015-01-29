//
//  DreamEmotionListView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

struct DreamEmotionProperty {
    let maxRows = 3
    let maxCols = 7
    let maxCountPerPage = 20
}

class DreamEmotionListView: UIView,UIScrollViewDelegate {
    var eomtions:NSArray?
    var scrollView:UIScrollView?
    var pageControl:UIPageControl?
    

    
    override init() {
        super.init()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView()
        self.scrollView?.delegate = self
        self.addSubview(scrollView!)
        
        pageControl = UIPageControl()
        pageControl?.hidesForSinglePage = true
        pageControl?.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage")
        pageControl?.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage")

        self.addSubview(pageControl!)
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pageControl?.frame = CGRectMake(0, self.height()-35, self.width(), 35)
        self.scrollView?.frame = CGRectMake(0, 0, self.width(), self.height()-35)
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.pagingEnabled = true
        self.scrollView?.contentSize = CGSizeMake(self.scrollView!.width() * CGFloat(Float(pageControl!.numberOfPages)), 0)
        let count = self.pageControl!.numberOfPages
        
        for var i=0;i<count;i++ {
            let gridView = self.scrollView?.subviews[i] as DreamEmotionGridView
            gridView.frame = CGRectMake( CGFloat(Float(i)) * self.width(), 0, self.width(), self.scrollView!.height())
        }
        
    }

    func setEmotions(emotions:NSArray){
        
        let properties = DreamEmotionProperty()
        let totalPages = (emotions.count + properties.maxCountPerPage - 1) / properties.maxCountPerPage

        
        pageControl?.numberOfPages = totalPages
        pageControl?.currentPage = 0
        let count = emotions.count

        let currentGridViewCount = self.scrollView!.subviews.count

        for var i=0;i<totalPages;i++ {
            var gridView:DreamEmotionGridView?
            if i>currentGridViewCount-1 {
                gridView = DreamEmotionGridView()
                self.scrollView?.addSubview(gridView!)

            }else{
                gridView = self.scrollView!.subviews[i] as? DreamEmotionGridView
            }
            
            gridView?.hidden = false
            let start = i*properties.maxCountPerPage
            let length = count-start < properties.maxCountPerPage ? count-start : properties.maxCountPerPage
            
            let gridViewEmotionsRange = NSMakeRange(start, length)
            let gridViewEmotions = emotions.subarrayWithRange(gridViewEmotionsRange)
            gridView!.setEmotions(gridViewEmotions)
            
        }
        
        for var i=totalPages;i<currentGridViewCount;i++ {
            (self.scrollView!.subviews[i] as? DreamEmotionGridView)?.hidden = true
        }

        self.scrollView?.contentOffset = CGPointZero
        self.setNeedsLayout()

        
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pageControl?.currentPage = Int(scrollView.contentOffset.x / scrollView.width() + 0.5)
    }
    
}
