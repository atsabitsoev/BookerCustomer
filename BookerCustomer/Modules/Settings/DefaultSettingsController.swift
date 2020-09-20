//
//  DefaultSettingsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultSettingsController: UIViewController, SettingsControlling {
    
    private var settingsView: SettingsViewing!
    private var alertManager: AlertManager!
    private let profileService = ProfileService()
    private var settingsService = SettingsService()
    
    private var notificationsIsOn: Bool!
    
    override func loadView() {
        super.loadView()
        settingsView = DefaultSettingsView(controller: self)
        settingsView.setupView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        alertManager = AlertManager(vc: self)
        configureView()
        setupNavigationBar()
        notificationsIsOn = settingsService.notificationsIsOn
    }
    
    func notificationsIsOnChanged(to newValue: Bool) {
        print("changed notificaionsIsOn")
        self.notificationsIsOn = newValue
        settingsView.enableSaveButton(true)
    }
    
    func saveButtonTapped(name: String?, lastname: String?) {
        
        settingsService.notificationsIsOn = notificationsIsOn
        
        guard let name = name,
            name.count > 3 else {
                alertManager.showAlert(
                    title: "Ошибка",
                    message: "Имя должно содержать не менее 3-х символов!",
                    action: nil
                )
                return
        }
        profileService.setNewProfileInfo(name: name, lastname: lastname) { [weak self] (succeed, userId, errorString) in
            guard succeed else {
                self?.alertManager.showAlert(
                    title: "Ошибка",
                    message: errorString ?? "Что-то пошло не так...",
                    action: nil
                )
                return
            }
        }
        settingsView.enableSaveButton(false)
    }
    
    private func setupNavigationBar() {
        let barQuitItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(alertQuit))
        self.navigationItem.rightBarButtonItem = barQuitItem
    }
    
    private func configureView() {
        profileService.getNameAndLastname { [weak self] (name, lastname, errorString) in
            guard let self = self else { return }
            if let errorString = errorString {
                self.alertManager.showAlert(title: "Ошибка", message: errorString, action: nil)
            }
            let name = name ?? ""
            let lastname = lastname ?? ""
            self.settingsView.configureView(name: name, lastname: lastname, notificationsOn: self.notificationsIsOn)
        }
    }
    
    @objc private func alertQuit() {
        let alert = UIAlertController(title: "Выйти?", message: "Вы уверены, что хотите выйти из своего аккаунта?", preferredStyle: .actionSheet)
        let quitAction = UIAlertAction(title: "Выйти", style: .destructive) { (_) in
            self.quit()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(quitAction)
        alert.addAction(cancelAction)
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
    
    private func quit() {
        do {
            try AuthService().logout()
            let authVC = DefaultEnterPhoneController()
            let authNav = BCNavigationController(rootViewController: authVC)
            authNav.modalPresentationStyle = .fullScreen
            authNav.modalTransitionStyle = .flipHorizontal
            self.tabBarController?.present(authNav, animated: true, completion: nil)
        } catch {
            return
        }
    }
}
