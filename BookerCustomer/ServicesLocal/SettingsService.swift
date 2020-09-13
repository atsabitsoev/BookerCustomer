//
//  SettingsService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 10.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation

final class SettingsService {
    
    var userPhone: String? {
        get {
            return UserDefaults.standard.string(forKey: "userPhone")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userPhone")
        }
    }
    
    var notificationsIsOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "notificationsIsOn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notificationsIsOn")
        }
    }
    
    var restaurantId: String {
        get {
            return "1ZbtQ8rexe5RgRAUiMTr"
        }
    }
}
