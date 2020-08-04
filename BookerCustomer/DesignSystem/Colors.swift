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
        static let titleLight = UIColor.white
        static let titleDark = UIColor.black
    }
    
    struct Background {
        static let primaryLight = UIColor(named: "backgroundPrimary")!
        static let primaryDark = UIColor.black
        static let pickerView = UIColor.white
        static let toolbar = UIColor.white
        static let titleLight = UIColor.white
        static let titleDark = UIColor.black
    }
    
    struct Cell {
        static let background = UIColor.Background.primaryLight
        static let mainView = UIColor.white
        static let description = UIColor(named: "cellDescription")!
        static let title = UIColor.black
    }
    
    struct Alert {
        static let mainView = UIColor.white
        static let background = UIColor.black.withAlphaComponent(0.5)
        static let title = UIColor.black
        static let message = UIColor.black
    }
    
    struct Shadow {
        static let main = UIColor(named: "shadowMain")!
    }
    
    struct Label {
        static let help = UIColor(named: "labelHelp")
    }
}
