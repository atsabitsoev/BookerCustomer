//
//  DefaultEnterPhoneController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 28.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterPhoneController: UIViewController, EnterPhoneController {
    
    private var enterPhoneView: EnterPhoneView!
    private var alertManager: AlertManager!
    private var authService = AuthService()
        
    override func loadView() {
        super.loadView()
        enterPhoneView = DefaultEnterPhoneView(controller: self)
        enterPhoneView.configureView()
        view = enterPhoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        self.alertManager = AlertManager(vc: self)
    }
    
    func sendCodeButtonTapped(phoneNumber: String?) {
        if let phoneNumber = phoneNumber {
            print(phoneNumber)
            authService.sendCode(toPhone: "+" + phoneNumber) { (verificationId, error) in
                guard let _ = verificationId else {
                    self.alertManager.showAlert(
                        title: "Ошибка",
                        message: error?.localizedDescription ?? "Неизвестная ошибка",
                        action: nil
                    )
                    return
                }
                self.enterPhoneView.showSmsTextField(true)
            }
        } else {
            alertManager.showAlert(title: "Ошибка", message: "Введен неверный номер телефона", action: nil)
        }
    }
    
    func smsCodeEntered(code: String) {
        authService.authenticate(
            verificationCode: code) { (succeed, wasRegistered, error) in
                switch succeed {
                case true:
                    if wasRegistered {
                        let mainTabBar = BCTabBarController()
                        mainTabBar.modalTransitionStyle = .crossDissolve
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self.navigationController?.present(
                            mainTabBar,
                            animated: true,
                            completion: nil
                        )
                    } else {
                        let enterNameVC = DefaultEnterNameController()
                        self.navigationController?.show(enterNameVC, sender: nil)
                    }
                case false:
                    self.alertManager.showAlert(
                        title: "Ошибка",
                        message: error?.localizedDescription ?? "Неизвестная ошибка",
                        action: nil
                    )
                }
        }
    }
}
