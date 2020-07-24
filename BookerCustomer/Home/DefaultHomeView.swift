//
//  HomeView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 19.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultHomeView: UIView, HomeViewing {
    
    private var controller: UIViewController & HomeControlling
    
    init(controller: UIViewController & HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
    }
    
    func getAlertController() -> UIViewController {
        let alert = SimpleAlertController(title: "Привет", message: "flsdkd fjlskjf ldksfj dlsk fjdslkf jsdlk fjlsdk fjl") {
            print("tap")
        }
        return alert
    }
    
    
}
