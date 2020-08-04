//
//  HomeView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeView: UIView, HomeViewing {
    
    private var controller: HomeControlling
    
    private lazy var orderView: OrderView = { [unowned self] in
        let startState = OrderView.State.orderReady
        let view = OrderView(
            state: startState,
            date: nil,
            personsCount: 1,
            onStateChange: self.onStateChange(state:))
        return view
    }()
    private let helpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let helpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Label.help
        label.textColor = UIColor.Label.help
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let helpStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(controller: HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupOrderViewConstraints()
        setupHelpStackViewConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primaryLight
        addSubview(orderView)
        addSubview(helpStackView)
        helpStackView.addArrangedSubview(helpImageView)
        helpStackView.addArrangedSubview(helpLabel)
        setNeedsUpdateConstraints()
    }
    
    private func onStateChange(state: OrderView.State) {
        switch state {
        case .shouldOrder:
            helpImageView.image = UIImage(named: "idea")!
            helpLabel.text = "Забронируйте столик\n прямо сейчас!"
        case .orderWaiting:
            helpImageView.image = UIImage(named: "hourglass")!
            helpLabel.text = "Скоро мы вам ответим"
        case .orderReady:
            helpImageView.image = UIImage(named: "congratulations")!
            helpLabel.text = "Ура! Ожидаем вас сегодня, в 19:00\nпо адресу: Ленина, 42!"
        }
    }
    
    private func setupOrderViewConstraints() {
        NSLayoutConstraint.activate([
            orderView.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            orderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func setupHelpStackViewConstraints() {
        NSLayoutConstraint.activate([
            helpStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height / 5),
            helpStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            helpStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
}
