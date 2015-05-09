//
//  LookupLocationViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/3/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit
import CoreLocation

class LookupLocationViewController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate {

    var mapView:BMKMapView!
    var locationService:BMKLocationService!
    var location:CLLocation?
    var composeViewController:ComposeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationItem()

        
        setupLocationRequireService()
        
        mapView = BMKMapView()
        mapView.frame = self.view.bounds
        self.view.addSubview(mapView)
        mapView.delegate = self

        locationService = BMKLocationService()

        locationService.delegate = self
        
        startLocation()
        
        // Do any additional setup after loading the view.
    }

    
    func setupNavigationItem(){
        self.title = "位置查询"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: UIBarButtonItemStyle.Done, target: self, action: "exit")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: "done")
        
        var textAttrs = NSMutableDictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttrs as [NSObject : AnyObject], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttrs as [NSObject : AnyObject], forState: UIControlState.Normal)
    }
    

    func exit(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done(){
        self.composeViewController.location = self.location
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupLocationRequireService(){
        let manager = CLLocationManager()
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestAlwaysAuthorization()
        }

    }
    
    func startLocation(){
        locationService.startUserLocationService()
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading
        mapView.showsUserLocation = true
    }
    
    func willStartLocatingUser() {
        NSLog("start locate")

    }
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        self.location = userLocation.location
        NSLog("location is %@",userLocation.location.altitude)
    }
    
    func didStopLocatingUser() {
        NSLog("stop locate")

    }

    func didFailToLocateUserWithError(error: NSError!) {
        NSLog("location error:%@",error);

    }
    

}
