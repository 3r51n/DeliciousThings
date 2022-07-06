//
//  ViewController.swift
//  DeliciousThings
//
//  Created by MacBook on 15.06.2022.
//

import UIKit

enum TabBarItem: Int {
    case home
    case allDishes

    var title: String {
        switch self {
        case .home  : return "Home"
        case .allDishes : return "All Dishes"
        }
    }

    var icon: UIImage {
        switch self {
        case .home: return UIImage(systemName: "house.circle") ?? .add
        case .allDishes: return UIImage(systemName: "magnifyingglass") ?? .add
        }
    }

    var viewController: UIViewController {
        switch self {
        case .home: return HomeRouter.setupModule()
        case .allDishes: return AllDishesRouter.setupModule()
        }
    }
}

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }

    private func configureTabBar() {
        let homeController = UINavigationController(rootViewController: TabBarItem.home.viewController)
   

        homeController.tabBarItem = UITabBarItem(title: TabBarItem.home.title,
                                                   image: TabBarItem.home.icon,
                                                   tag: TabBarItem.home.rawValue)

        let homeController2 = UINavigationController(rootViewController: TabBarItem.allDishes.viewController)
     

          homeController2.tabBarItem = UITabBarItem(title: TabBarItem.allDishes.title,
                                                     image: TabBarItem.allDishes.icon,
                                                     tag: TabBarItem.allDishes.rawValue)
   

        viewControllers = [homeController, homeController2]
    }
}
