//
//  AppDelegate.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import UIKit
import CocoaLumberjack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (self.window == nil) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.white
        }
        
        /* Uses os_log */
        DDLog.add(DDOSLogger.sharedInstance)

        /* Create ui-view-controller instance */
        let product = ProductRouter.createModule()

        /* Initiating instance of ui-navigation-controller with view-controller */
        let rootNavController = UINavigationController()
        rootNavController.navigationBar.isHidden = true
        rootNavController.viewControllers = [product]
        
        self.window?.rootViewController = rootNavController
        self.window?.makeKeyAndVisible()
        return true
    }
}

