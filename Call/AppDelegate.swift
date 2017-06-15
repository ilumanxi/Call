//
//  AppDelegate.swift
//  Call
//
//  Created by 风起兮 on 16/5/18.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let tabbarController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController  = tabbarController
        window?.backgroundColor = UIColor.orange
        window?.makeKeyAndVisible()
        
        themeRendering()
        
        return true
    }
    
    func themeRendering()  {
        
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor.rawValue:Color.themeColor], for: .selected)
        UITabBar.appearance().tintColor = Color.themeColor
        UIBarButtonItem.appearance().tintColor = Color.themeColor
    }
    

    


}

