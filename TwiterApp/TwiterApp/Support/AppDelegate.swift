//
//  AppDelegate.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        let navi = BaseNaviViewController(viewModel: BaseNaviViewModel())
        window!.rootViewController = navi
        window!.makeKeyAndVisible()
        return true
    }
}

