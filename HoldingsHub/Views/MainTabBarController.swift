//
//  MainTabBarController.swift
//  HoldingsHub
//
//  Created by Preity Singh on 20/11/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       config()
       configureTabBarAppearance()
    }
   
   func config () {
      view.backgroundColor = .darkGray
      let homeVC = UIViewController()
      homeVC.view.backgroundColor = .white
      homeVC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "list.bullet"), tag: 0)

      let searchVC = UIViewController()
      searchVC.view.backgroundColor = .white
      searchVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "clock.arrow.circlepath"), tag: 1)

      let portfolioVC = PortfolioViewController()
      portfolioVC.view.backgroundColor = .white
      portfolioVC.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "bag.badge.plus"), tag: 2)

      let notificationsVC = UIViewController()
      notificationsVC.view.backgroundColor = .white
      notificationsVC.tabBarItem = UITabBarItem(title: "Funds", image: UIImage(systemName: "indianrupeesign"), tag: 3)

      let profileVC = UIViewController()
      profileVC.view.backgroundColor = .white
      profileVC.tabBarItem = UITabBarItem(title: "Invest", image: UIImage(systemName: "handbag"), tag: 4)


      viewControllers = [homeVC, searchVC, portfolioVC, notificationsVC, profileVC]
      selectedIndex = 2
   }
   
   private func configureTabBarAppearance() {
       let appearance = UITabBarAppearance()
       appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .gray

       tabBar.standardAppearance = appearance
       if #available(iOS 15.0, *) {
           tabBar.scrollEdgeAppearance = appearance
       }
   }
}

