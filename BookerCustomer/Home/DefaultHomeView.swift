//
//  HomeView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeView: UIView, HomeViewing {
    
    private var controller: UIViewController & HomeControlling
    
    private let orderView = OrderView(state: .shouldOrder, date: Date(), personsCount: 1)
    
    init(controller: UIViewController & HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
        addSubview(orderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupOrderViewConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        setNeedsUpdateConstraints()
    }
    
    private func setupOrderViewConstraints() {
        NSLayoutConstraint.activate([
            orderView.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            orderView.heightAnchor.constraint(equalToConstant: 148),
            orderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
}
