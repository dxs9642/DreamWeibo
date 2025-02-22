//
//  DreamTabBar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/17/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

protocol PlusButtonProtocol{
    func plusButtonClick()
}

class DreamTabBar: UITabBar {
    
    var plusButton:UIButton?
    var plusDelegate:PlusButtonProtocol?
    
    
    
    convenience init(){
        let frame = CGRectMake(0, 0, 0, 0)
        self.init(frame:frame)
    }
    
    
    func setupPlusButton(){
        var plusButton = UIButton()
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        plusButton.setImage(UIImage(named:"tabbar_compose_icon_add"),forState:UIControlState.Normal)
        plusButton.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"),forState:UIControlState.Highlighted)
        plusButton.addTarget(self, action: "plusClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(plusButton)
        self.plusButton = plusButton;
    }
    
    func plusClick(){
        plusDelegate?.plusButtonClick()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlusButton()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupTabBarButtonFrame()
        setupPlusButtonFrame()
    }
    
    func setupPlusButtonFrame(){
        self.plusButton!.size = self.plusButton!.currentBackgroundImage!.size
        self.plusButton!.center = CGPointMake(self.width*0.5, self.height*0.5)
    
    }
    
    func setupTabBarButtonFrame(){
        var index = 0
        
        var count = CGFloat(Float(self.items!.count+1))
        
        
        for tabbarButton in self.subviews {
            if tabbarButton.isKindOfClass(NSClassFromString("UITabBarButton")){
                let tabbar = tabbarButton as! UIView
                if index<2 {
                    tabbar.frame = CGRectMake(self.width/count*CGFloat(Float(index)), 0, self.width/count, self.height)
                }else{
                    tabbar.frame = CGRectMake(self.width/count*CGFloat(Float(index+1)), 0, self.width/count, self.height)
                }
                index++
                
            }
        }
        
    }
    

}
