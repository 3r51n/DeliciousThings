//
//  AppDelegate.swift
//  DeliciousThings
//
//  Created by MacBook on 15.06.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppRouter.shared.start()
        return true
    }
}
