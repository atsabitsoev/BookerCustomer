//
//  DefaultEnterNameController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterNameController: UIViewController, EnterNameControlling {
    
    private var enterNameView: EnterNameViewing!
    private var alertManager: AlertManager!
    private let profileService = ProfileService()
    
    override func loadView() {
        super.loadView()
        enterNameView = DefaultEnterNameView(controller: self)
        enterNameView.configureView()
        alertManager = AlertManager(vc: self)
        view = enterNameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
    }
    
    func nextButtonTapped(name: String, lastname: String?) {
        profileService.setNewProfileInfo(name: name, lastname: lastname) { [weak self] (_, userId, errorString) in
            guard let userId = userId else {
                self?.alertManager.showAlert(
                    title: "Ошибка",
                    message: errorString ?? "Что-то пошло не так...",
                    action: nil
                )
                return
            }
            SettingsService().userEntityId = userId
        }
        let mainTabBar = BCTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        mainTabBar.modalTransitionStyle = .crossDissolve
        self.present(mainTabBar, animated: true, completion: nil)
    }
}
