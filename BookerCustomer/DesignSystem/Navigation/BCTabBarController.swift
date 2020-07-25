//
//  BCTabBarController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.Background.secondary
        tabBar.tintColor = UIColor.Button.tapOnMe
        let homeVC = BCNavigationController(rootViewController: DefaultHomeController())
        homeVC.tabBarItem = UITabBarItem(title: "Бронь", image: UIImage(named: "orderTabBarItem"), tag: 0)
        let promotionsVC = BCNavigationController(rootViewController: DefaultPromotionsController())
        promotionsVC.tabBarItem = UITabBarItem(title: "Акции", image: UIImage(named: "promotionsTabBarItem"), tag: 1)
        viewControllers = [homeVC, promotionsVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
