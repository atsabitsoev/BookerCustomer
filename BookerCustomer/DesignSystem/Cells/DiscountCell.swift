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
        return view
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
        return imageView
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
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
        mainView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        chevronImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        mainView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(titleLabel)
        horizontalStack.addArrangedSubview(chevronImage)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            horizontalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            horizontalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            chevronImage.widthAnchor.constraint(equalToConstant: 16),
            chevronImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainView.alpha = selected ? 0.5 : 1
    }
}
