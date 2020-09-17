//
//  DefaultDiscountsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultDiscountsController: UIViewController, DiscountsControlling {
    
    private var discountsView: DiscountsViewing!
    private let discountsBackendService = DiscountsBackendService()
    private let discountsQrService = DiscountsQrService()
    private lazy var alertManager = AlertManager(vc: self)
    
    private var discounts: [Discount] = []
    
    override func loadView() {
        super.loadView()
        discountsView = DefaultDiscountsView(controller: self)
        discountsView.configureView()
        view = discountsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои скидки"
        setupNavigationBar()
        fetchDiscounts()
    }
    
    
    func showQrCode(discountId: String) {
        let discountOptional = discounts.first { (discount) -> Bool in
            return discount.id == discountId
        }
        guard let discount = discountOptional,
            let qrCode = discountsQrService.generateQrCode(
                discountId: discountId,
                discountDescription: discount.description,
                userEntityId: discount.userEntityId
            )
            else { return }
        let discountVC = DefaultDiscountController(qrCode: qrCode, discountDescription: discount.description)
        self.navigationController?.show(discountVC, sender: nil)
    }
    
    
    private func fetchDiscounts() {
        discountsBackendService.getAllDiscounts { [weak self] (discounts, errorString) in
            guard let self = self else { return }
            guard let discounts = discounts else {
                self.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
                return
            }
            self.discounts = discounts
            let discountItems = discounts.map { (discount) -> DiscountItem in
                return DiscountItem(id: discount.id, name: discount.description)
            }
            self.discountsView.setDiscountItems(discountItems)
        }
    }
    
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "qrcodeButton"), style: .plain, target: self, action: #selector(qrcodeButtonTapped))
    }
    
    @objc private func qrcodeButtonTapped() {
        self.navigationController?.show(ScannerViewController(), sender: nil)
    }
    
}
