//
//  Context.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import UIKit

open class Context : NSObject {
    
    class func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }

    class func getAppName() -> String {
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        return appName.unwrap
    }

    class func getAppVersion() -> String {
        let appVersion =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        return appVersion.unwrap
    }
}
