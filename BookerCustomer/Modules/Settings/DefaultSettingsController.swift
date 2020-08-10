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
        let nameAndLastname = profileService.getNameAndLastname()
        let name = nameAndLastname.0
        let lastname = nameAndLastname.1
        let notificationsIsOn = settingsService.notificationsIsOn
        settingsView.configureView(name: name, lastname: lastname, notificationsOn: notificationsIsOn)
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        alertManager = AlertManager(vc: self)
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
        profileService.setNewProfileInfo(name: name, lastname: lastname) { (error) in
            if let error = error {
                self.alertManager.showAlert(
                    title: "Ошибка",
                    message: error.localizedDescription,
                    action: nil
                )
                return
            }
        }
        settingsView.enableSaveButton(false)
    }
}
