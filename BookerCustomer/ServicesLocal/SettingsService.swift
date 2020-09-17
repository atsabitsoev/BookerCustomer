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
    
    var userEntityId: String? {
        get {
            return UserDefaults.standard.string(forKey: "userEntityId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userEntityId")
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
    
    var restaurantName: String? {
        get {
            return UserDefaults.standard.string(forKey: "restaurantName")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "restaurantName")
        }
    }
    
    var restaurantAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: "restaurantAddress")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "restaurantAddress")
        }
    }
    
    private func updateRestaurantValues() {
        RestaurantService().getRestaurantInfo { (name, address, error) in
            if error == nil {
                self.restaurantName = name
                self.restaurantAddress = address
            }
        }
    }
    
    private func updateUserValues() {
        AuthService().getUserEntityId { (userEntityId, errorString) in
            guard let userEntityId = userEntityId else {
                print(errorString ?? "Неизвестная ошибка при попытке получить userEntityId")
                return
            }
            self.userEntityId = userEntityId
        }
    }
    
    func updateValues() {
        updateRestaurantValues()
        updateUserValues()
    }
    
}
