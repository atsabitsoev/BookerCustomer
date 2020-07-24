//
//  BCSwitchCell.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCSwitchCell: UITableViewCell {
    
    private let onSwitchAction: (Bool) -> ()
    private let titleOn: String
    private let titleOff: String
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.layer.cornerRadius = 16
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.title
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = UIColor.Button.tapOnMe
        return switchControl
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    init(titleOn: String, titleOff: String, isOn: Bool, action: @escaping (Bool) -> ()) {
        self.onSwitchAction = action
        self.titleOn = titleOn
        self.titleOff = titleOff
        titleLabel.text = isOn ? titleOn : titleOff
        switchControl.setOn(isOn, animated: false)
        super.init(style: .default, reuseIdentifier: nil)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupMainViewConstraints()
        setupHorizontalStackConstraints()
        super.updateConstraints()
    }
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Cell.background
        switchControl.addTarget(self, action: #selector(onSwitchChange), for: .valueChanged)
        contentView.addSubview(mainView)
        mainView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(titleLabel)
        horizontalStack.addArrangedSubview(switchControl)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        setNeedsUpdateConstraints()
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupHorizontalStackConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            horizontalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func onSwitchChange() {
        onSwitchAction(switchControl.isOn)
        horizontalStack.removeArrangedSubview(titleLabel)
        titleLabel.text = switchControl.isOn ? titleOn : titleOff
        horizontalStack.insertArrangedSubview(titleLabel, at: 0)
    }
}
