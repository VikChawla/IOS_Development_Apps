//
//  AppDelegate.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/16/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationFont = UIFont(name: "Avenir Black", size: 40)
        let navigationFontAttributes = [NSAttributedString.Key.font : navigationFont]
        UINavigationBar.appearance().titleTextAttributes = navigationFontAttributes
       // UIBarButtonItem.appearance().setTitleTextAttributes(navigationFontAttributes, for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = navigationFontAttributes
       // navigationController.navigationBar.shadowImage = UIImage()
        return true
    }

    // MARK: UISceneSession Lifecycle

   @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           // Called when a new scene session is being created.
           // Use this method to select a configuration to create the new scene with.
           return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
       }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
  

}

