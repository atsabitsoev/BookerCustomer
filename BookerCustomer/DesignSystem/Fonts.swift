//
//  Fonts.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 21.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

extension UIFont {
    
    struct Button {
        static let primary = UIFont.systemFont(ofSize: 14)
        static let secondary = UIFont.systemFont(ofSize: 16)
    }
    
    struct Cell {
        static let bigTitle = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let title = UIFont.systemFont(ofSize: 16)
        static let description = UIFont.systemFont(ofSize: 12)
    }
}
