//
//  DiscountsProtocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol DiscountsViewing: UIView {
    func configureView()
    func setDiscountItems(_ items: [DiscountItem])
}

protocol DiscountsControlling: UIViewController {
    func showQrCode(discountId: String)
}
