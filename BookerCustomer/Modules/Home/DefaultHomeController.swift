//
//  HomeViewController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeController: UIViewController, HomeControlling {
    
    private var homeView: HomeViewing!
    private let orderService = OrderService()
    private lazy var alertManager = AlertManager(vc: self.tabBarController!)
    
    private var currentOrder: Order? {
        didSet {
            guard let currentOrder = currentOrder else {
                homeView.showOrderView(state: .shouldOrder, personsCount: 1, date: nil)
                return
            }
            var orderViewState: OrderView.State = .shouldOrder
            switch currentOrder.state {
            case .waiting:
                orderViewState = .orderWaiting
            case .ready:
                orderViewState = .orderReady
            }
            homeView.showOrderView(state: orderViewState, personsCount: currentOrder.personsCount, date: currentOrder.date)
        }
    }
    
    override func loadView() {
        super.loadView()
        title = "Бронирование"
        homeView = DefaultHomeView(controller: self)
        homeView.configureView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentOrder()
        NotificationCenter.default.addObserver(self, selector: #selector(viewEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkActiveMessage()
    }
    
    @objc private func viewEnteredForeground() {
        checkActiveMessage()
    }
    
    func alertCreateOrder(withDate date: Date, personsCount: Int) {
        let alert = UIAlertController(title: "Бронирование", message: "Вы уверены что хотите забронировать столик на дату: \(date.toString()) и количество человек: \(personsCount)?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Забронировать", style: .default) { [weak self] (_) in
            self?.createOrder(withDate: date, personsCount: personsCount)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertRejectOrder() {
        let alert = UIAlertController(title: "Вы уверены?", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let rejectAction = UIAlertAction(title: "Удалить бронь", style: .destructive) { [weak self] (_) in
            self?.rejectOrder()
        }
        alert.addAction(cancelAction)
        alert.addAction(rejectAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createOrder(withDate date: Date, personsCount: Int) {
        orderService.createOrder(date: date, personNumber: personsCount) { [weak self] (succeed, errorString) in
            if succeed {
                self?.alertManager.showAlert(title: "Ура!", message: "Бронь с датой: \(date.toString()) на количество человек: \(personsCount) успешно создана.\nОжидайте подтверждения менеджера...", action: nil)
            } else {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так, попробуйте еще раз...", action: nil)
            }
        }
    }
    
    private func rejectOrder() {
        orderService.deleteOrder { [weak self] (succeed, errorString) in
            if !succeed {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
            }
        }
    }
    
    private func fetchCurrentOrder() {
        orderService.getCurrentOrderIfExist { [weak self] (order, error) in
            if let order = order {
                self?.currentOrder = order
            } else if let error = error {
                self?.alertManager.showAlert(title: "Ошибка", message: error, action: nil)
            } else {
                self?.homeView.showOrderView(state: .shouldOrder, personsCount: 1, date: nil)
            }
        }
    }
    
    private func checkActiveMessage() {
        orderService.getActiveMessage { [weak self] (message, errorString) in
            if let message = message {
                self?.alertManager.showAlert(title: "Бронь отменена :(", message: message, action: {
                    self?.orderService.deleteMessage({ (succeed) in
                        if !succeed {
                            self?.alertManager.showAlert(title: "Ошибка", message: "Что-то пошло не так...", action: nil)
                        }
                    })
                })
            } else if let errorString = errorString {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString, action: nil)
            }
        }
    }
    
    
}
