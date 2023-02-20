//
//  AppDelegate.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import CoreData
import Firebase
import Resolver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Resolver.reset()
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        let navi = BaseNaviViewController(viewModel: BaseNaviViewModel())
        if Self.inUnitTest {
            window!.rootViewController = UIViewController()
        } else {
            window!.rootViewController = navi
        }
        
        window!.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    static var inUnitTest: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}

