//
//  Colors.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 21.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Button {
        static let tapOnMe = UIColor(named: "buttonTapOnMe")
        static let waiting = UIColor(named: "buttonWaiting")
        static let ready = UIColor(named: "buttonReady")
        static let destructive = UIColor(named: "buttonDestructive")
        static let title = UIColor.white
    }
    
    struct Background {
        static let primary = UIColor(named: "backgroundPrimary")
        static let secondary = UIColor(named: "backgroundSecondary")
        static let pickerView = UIColor.black.withAlphaComponent(0.95)
        static let toolbar = UIColor.black
    }
}
