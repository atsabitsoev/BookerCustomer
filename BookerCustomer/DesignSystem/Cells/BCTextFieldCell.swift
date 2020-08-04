//
//  BCTextFieldCell.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 24.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCTextFieldCell: UITableViewCell {
    
    var delegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = delegate
        }
    }
    var textFieldTag: Int? {
        didSet {
            textField.tag = textFieldTag ?? 0
        }
    }

    private let cornerRadius: CGFloat = 16
    
    var textField: TitlableTextField
    
    init(textField: TitlableTextField) {
        self.textField = textField
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        super.init(style: .default, reuseIdentifier: nil)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupTextFieldConstraints()
        super.updateConstraints()
    }
    
    func configureCell(with text: String?) {
        textField.text = text
    }
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Background.primaryLight
        contentView.addSubview(textField)
        setNeedsUpdateConstraints()
    }
    
    private func setupTextFieldConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            textField.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    
}
