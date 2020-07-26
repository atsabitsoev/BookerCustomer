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
    
    override func loadView() {
        super.loadView()
        title = "Настройки"
        settingsView = DefaultSettingsView(controller: self)
        settingsView.configureView(name: "Андрей", lastname: "Петров", notificationsOn: true)
        view = settingsView
    }
    
    func nameChanged(to newName: String) {
        print("name changed to \(newName)")
        settingsView.enableSaveButton(true)
    }
    
    func lastnameChanged(to newLastname: String) {
        print("lastname changed to \(newLastname)")
        settingsView.enableSaveButton(true)
    }
    
    func notificationsIsOnChanged(to newValue: Bool) {
        print("changed notificaionsIsOn")
        settingsView.enableSaveButton(true)
    }
    
    func saveButtonTapped() {
        print("saving data")
        settingsView.enableSaveButton(false)
    }
}
