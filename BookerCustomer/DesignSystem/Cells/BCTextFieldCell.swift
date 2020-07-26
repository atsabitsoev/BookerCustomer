//
//  BCTextFieldCell.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 24.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCTextFieldCell: UITableViewCell {
    
    private var isFirstCell = false
    private var isLastCell = false
    private var placeholder: String?
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
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.layer.cornerRadius = cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let noCornersViewTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let noCornersViewBottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.Cell.bigTitle
        tf.textColor = UIColor.Cell.title
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    init(
        isFirstCell: Bool,
        isLastCell: Bool,
        placeholder: String?) {
        self.isFirstCell = isFirstCell
        self.isLastCell = isLastCell
        self.placeholder = placeholder
        super.init(style: .default, reuseIdentifier: nil)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupMainViewConstraints()
        setupNoCornersViewConstraints()
        setupTextFieldConstraints()
        super.updateConstraints()
    }
    
    func configureCell(with text: String?) {
        textField.text = text
    }
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Background.primary
        textField.placeholder = placeholder
        contentView.addSubview(noCornersViewTop)
        contentView.addSubview(noCornersViewBottom)
        contentView.addSubview(mainView)
        mainView.addSubview(textField)
        noCornersViewTop.isHidden = isFirstCell
        noCornersViewBottom.isHidden = isLastCell
        setNeedsUpdateConstraints()
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupNoCornersViewConstraints() {
        NSLayoutConstraint.activate([
            noCornersViewTop.topAnchor.constraint(equalTo: mainView.topAnchor),
            noCornersViewTop.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            noCornersViewTop.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            noCornersViewTop.heightAnchor.constraint(equalToConstant: cornerRadius)
        ])
        
        NSLayoutConstraint.activate([
            noCornersViewBottom.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            noCornersViewBottom.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            noCornersViewBottom.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            noCornersViewBottom.heightAnchor.constraint(equalToConstant: cornerRadius)
        ])
    }
    
    private func setupTextFieldConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 28),
            textField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
    }
    
}
