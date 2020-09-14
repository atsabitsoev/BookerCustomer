//
//  DefaultPromotionsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsController: UIViewController, PromotionsControlling {
    
    private var promotionsView: PromotionsViewing!
    private let promotionService = PromotionService()
    private lazy var alertManager = AlertManager(vc: self.tabBarController!)
    
    private var promotions: [Promotion] = [] {
        didSet {
            self.promotionsView.setPromotionItems(promotions.map({ (promotion) -> PromotionItem in
                let title = promotion.title
                let description = promotion.description
                let imageUrl = promotion.image
                let promotionItem = PromotionItem(imageUrl: imageUrl, title: title, description: description)
                return promotionItem
            }))
        }
    }
    
    
    override func loadView() {
        super.loadView()
        title = "Акции"
        promotionsView = DefaultPromotionsView(controller: self)
        promotionsView.configureView()
        view = promotionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPromotions()
    }
    
    private func fetchPromotions() {
        promotionService.getAllPromotions { (promotions, errorString) in
            if let promotions = promotions {
                self.promotions = promotions
            } else {
                self.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что то пошло не так...", action: nil)
            }
        }
    }
    
}
