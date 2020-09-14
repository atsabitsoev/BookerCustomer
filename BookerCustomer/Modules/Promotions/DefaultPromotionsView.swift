//
//  DefaultPromotionsView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsView: UIView, PromotionsViewing {
    
    private var controller: PromotionsControlling
    
    fileprivate var promotionItems: [PromotionItem] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor.Background.primaryLight
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PromotionCell.self, forCellReuseIdentifier: PromotionCell.identifier)
        return table
    }()
    
    init(controller: PromotionsControlling) {
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
        backgroundColor = UIColor.Background.primaryLight
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    func setPromotionItems(_ items: [PromotionItem]) {
        self.promotionItems = items
        tableView.reloadData()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

extension DefaultPromotionsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromotionCell.identifier) as? PromotionCell else { return UITableViewCell() }
        let currentItem = promotionItems[indexPath.row]
        cell.configureCell(imageUrl: currentItem.imageUrl ?? "", title: currentItem.title, description: currentItem.description)
        return cell
    }
    
}
