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
    
    private let mainView: OrderView = {
        let view = OrderView(state: .shouldOrder, date: Date(), personsCount: 1)
        return view
    }()
    
    
    init(controller: UIViewController & HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        addSubview(mainView)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])
        super.updateConstraints()
    }
}
