//
//  Date+Extensions.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 21.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "H:mm"
        
        return "\(dateFormatter.string(from: self)), \(timeFormatter.string(from: self))"
    }
}
