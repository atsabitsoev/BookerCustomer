//
//  Protocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol HomeViewing: UIView {
    func configureView()
    func showOrderView(state: OrderView.State, personsCount: Int, date: Date?)
}

protocol HomeControlling: UIViewController {
    func alertCreateOrder(withDate date: Date, personsCount: Int)
    func alertRejectOrder()
}
