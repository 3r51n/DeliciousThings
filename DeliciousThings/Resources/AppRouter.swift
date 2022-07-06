//
//  AppRouter.swift
//  DeliciousThings
//
//  Created by MacBook on 21.06.2022.
//

import Foundation
import UIKit

class AppRouter {

    public static var shared = AppRouter()

    var window: UIWindow?

    func start() {
        let viewController = TabBarViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
