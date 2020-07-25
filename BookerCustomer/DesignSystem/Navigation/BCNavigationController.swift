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
        navigationBar.barTintColor = UIColor.Background.secondary
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Background.title]
        navigationBar.tintColor = UIColor.Button.tapOnMe
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}
