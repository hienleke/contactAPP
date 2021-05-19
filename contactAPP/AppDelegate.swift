//
//  AppDelegate.swift
//  contactAPP
//
//  Created by TMA on 5/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   //   window =  UIWindow(frame: UIScreen.main.bounds)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    func applicationWillTerminate(_ application: UIApplication) {
    
    }
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(window?.rootViewController!)
        if let NavviewController = self.window?.rootViewController as? UINavigationController
       {
            let viewcontroller = NavviewController.viewControllers[0] as! ViewController
            viewcontroller.fetchAfterchange()
    
           
       }
   
    }


}

