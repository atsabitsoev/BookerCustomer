//
//  DiscountCell.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 22.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DiscountCell: UITableViewCell {
    
    static let identifier = "DiscountCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.Shadow.main.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "saleIcon")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.title
        label.numberOfLines = 0
        return label
    }()
    private let chevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevronRight")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(title: String) {
        titleLabel.text = title
    }
    
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Cell.background
        contentView.addSubview(mainView)
        mainView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(iconImage)
        horizontalStack.addArrangedSubview(titleLabel)
        horizontalStack.addArrangedSubview(chevronImage)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            horizontalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24),
            horizontalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            chevronImage.widthAnchor.constraint(equalToConstant: 16),
            chevronImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainView.alpha = selected ? 0.5 : 1
    }
}
