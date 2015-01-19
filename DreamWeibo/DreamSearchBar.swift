//
//  DreamSearchBar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/16/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamSearchBar: UITextField {

    class func buildSearchBar() -> DreamSearchBar {
        var searchBar = DreamSearchBar()
        searchBar.frame = CGRectMake(0, 0, 300, 30)
        searchBar.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        searchBar.background = UIImage.resizeImage("searchbar_textfield_background")
        var imageVeiw = UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        
        imageVeiw.setWidth(searchBar.height())
        imageVeiw.setHeight(searchBar.height())
        imageVeiw.contentMode = UIViewContentMode.Center
        
        searchBar.leftView = imageVeiw
        searchBar.leftViewMode = UITextFieldViewMode.Always
        searchBar.clearButtonMode = UITextFieldViewMode.WhileEditing
        return searchBar
        
    }
    
}
