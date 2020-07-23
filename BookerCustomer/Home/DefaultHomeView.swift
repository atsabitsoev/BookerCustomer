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
    
    private let tableView = UITableView()
    
    
    init(controller: UIViewController & HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        super.updateConstraints()
    }
}

extension DefaultHomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PromotionCell()
        cell.configureCell(imageUrl: "https://img5.goodfon.ru/original/1920x1080/8/9c/abstraktsiia-fon-kartinka-sinii-goluboi-smeshenie-tsvetov-kr.jpg", title: "Привет", description: "Андрей")
        return cell
    }
    
}
