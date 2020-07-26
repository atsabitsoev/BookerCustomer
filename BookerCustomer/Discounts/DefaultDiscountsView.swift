//
//  DefaultDiscountsView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultDiscountsView: UIView, DiscountsViewing {
    
    private var controller: DiscountsControlling
    
    fileprivate var discountItems: [DiscountItem] = [
        DiscountItem(name: "Скидка номер раз"),
        DiscountItem(name: "Скидка номер 2")]
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor.Background.primary
        table.register(DiscountCell.self, forCellReuseIdentifier: DiscountCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = false
        return table
    }()
    
    init(controller: DiscountsControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupTableViewConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setNeedsUpdateConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

extension DefaultDiscountsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discountItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscountCell.identifier) as? DiscountCell else { return UITableViewCell() }
        let currentItem = discountItems[indexPath.row]
        cell.configureCell(title: currentItem.name)
        return cell
    }
    
}
