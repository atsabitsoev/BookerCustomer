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
        let mainTabBar = BCTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        mainTabBar.modalTransitionStyle = .crossDissolve
        self.present(mainTabBar, animated: true, completion: nil)
    }
}
