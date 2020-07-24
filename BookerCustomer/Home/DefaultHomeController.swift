//
//  HomeViewController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeController: UIViewController, HomeControlling {
    
    private var homeView: (UIView & HomeViewing)!
    
    override func loadView() {
        super.loadView()
        homeView = DefaultHomeView(controller: self)
        homeView.configureView()
        self.view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(homeView.getAlertController(), animated: true, completion: nil)
    }
}
