//
//  BCNavigationController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.Background.primaryLight
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.NavigationBar.title]
        navigationBar.tintColor = UIColor.Button.tapOnMe
        navigationBar.shadowImage = UIImage()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
}
