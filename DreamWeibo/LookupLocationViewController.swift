//
//  LookupLocationViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/3/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class LookupLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        let mapView = BMKMapView()
        mapView.frame = self.view.bounds
        self.view.addSubview(mapView)
        
        // Do any additional setup after loading the view.
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
