//
//  DefaultDiscountsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultDiscountsController: UIViewController, DiscountsControlling {
    
    private var discountsView: DiscountsViewing!
    
    override func loadView() {
        super.loadView()
        title = "Мои скидки"
        setupNavigationBar()
        discountsView = DefaultDiscountsView(controller: self)
        discountsView.configureView()
        view = discountsView
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "qrcodeButton"), style: .plain, target: self, action: #selector(qrcodeButtonTapped))
    }
    
    @objc private func qrcodeButtonTapped() {
        print("open scan qr")
    }
    
}
