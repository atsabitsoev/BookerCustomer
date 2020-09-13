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
    private let orderService = OrderService()
    private lazy var alertManager = AlertManager(vc: self)
    
    private var currrentOrder: Order?
    
    override func loadView() {
        super.loadView()
        title = "Бронирование"
        homeView = DefaultHomeView(controller: self)
        homeView.configureView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentOrder()
    }
    
    private func fetchCurrentOrder() {
        orderService.getCurrentOrderIfExist { [weak self] (order, error) in
            if let order = order {
                self?.currrentOrder = order
            } else if let error = error {
                self?.alertManager.showAlert(title: "Ошибка", message: error, action: nil)
            }
        }
    }
    
    
}
