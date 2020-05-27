//
//  AppDelegate.swift
//  admod
//
//  Created by Dori on 5/27/20.
//  Copyright © 2020 obeidy. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }

  



}

