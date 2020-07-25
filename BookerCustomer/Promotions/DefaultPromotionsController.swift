//
//  DefaultPromotionsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsController: UIViewController, PromotionsControlling {
    
    private var promotionsView: (UIView & PromotionsViewing)!
    
    
    override func loadView() {
        super.loadView()
        title = "Акции"
        promotionsView = DefaultPromotionsView(controller: self)
        promotionsView.configureView()
        view = promotionsView
    }
    
}
