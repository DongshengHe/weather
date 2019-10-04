//
//  AppDelegate.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init()
        let homePageVC = HomePageListViewController()
        window?.rootViewController = UINavigationController.init(rootViewController: homePageVC)
        window?.makeKeyAndVisible()
        
        return true
    }

}

