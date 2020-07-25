//
//  PromotionCell.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 22.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import SDWebImage

final class PromotionCell: UITableViewCell {
    
    static let identifier = "PromotionCell"
    
    private let horizontalInset: CGFloat = 26
    private let verticalInset: CGFloat = 10
    
    private let promotionImage = UIImageView()
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.Cell.mainView
        return view
    }()
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.bigTitle
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.description
        label.font = UIFont.Cell.description
        label.numberOfLines = 0
        return label
    }()
    private let mainVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    private let descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupPromotionImageConstraints()
        setupMainViewConstraints()
        setupMainVerticalStackConstraints()
        setupDescriptionStackConstraints()
        super.updateConstraints()
    }
    
    func configureCell(
        imageUrl: String,
        title: String,
        description: String) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = URL(string: imageUrl) {
            promotionImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        } else {
            promotionImage.image = placeholderImage
        }
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Cell.background
        contentView.addSubview(mainView)
        mainView.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(promotionImage)
        mainVerticalStack.addArrangedSubview(descriptionView)
        descriptionView.addSubview(descriptionStack)
        descriptionStack.addArrangedSubview(titleLabel)
        descriptionStack.addArrangedSubview(descriptionLabel)
        setNeedsUpdateConstraints()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPromotionImageConstraints() {
        let imageWidth = UIScreen.main.bounds.width - 2 * horizontalInset
        let imageHeight = imageWidth / 16 * 9
        NSLayoutConstraint.activate([
            promotionImage.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalInset),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset)
        ])
    }
    
    private func setupMainVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            mainVerticalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            mainVerticalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            mainVerticalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            mainVerticalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupDescriptionStackConstraints() {
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionStack.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -8),
            descriptionStack.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16)
        ])
    }
}
