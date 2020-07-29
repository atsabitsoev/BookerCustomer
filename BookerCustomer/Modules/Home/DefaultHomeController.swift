//
//  HomeViewController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeController: UIViewController, HomeControlling {
    
    private var homeView: HomeViewing!
    
    override func loadView() {
        super.loadView()
        title = "Бронирование"
        homeView = DefaultHomeView(controller: self)
        homeView.configureView()
        self.view = homeView
    }
}