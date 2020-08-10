//
//  SettingsProtocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol SettingsViewing: UIView {
    func configureView(name: String, lastname: String, notificationsOn: Bool)
    func enableSaveButton(_ enable: Bool)
}

protocol SettingsControlling: UIViewController {
    func notificationsIsOnChanged(to newValue: Bool)
    func saveButtonTapped(name: String?, lastname: String?)
}
