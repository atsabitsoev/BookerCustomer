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
    
    override func loadView() {
        super.loadView()
        enterPhoneView = DefaultEnterPhoneView(controller: self)
        enterPhoneView.configureView()
        view = enterPhoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        enterPhoneView.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            self.enterPhoneView.showSmsTextField(true)
        }
        
    }
}
