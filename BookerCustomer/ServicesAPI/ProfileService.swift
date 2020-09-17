//
//  ProfileService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 10.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore

final class ProfileService {
    
    func setNewProfileInfo(
        name: String?,
        lastname: String?,
        _ handler: ((Bool, String?, String?) -> Void)? = nil
    ) {
        guard let phone = SettingsService().userPhone,
            let name = name,
            let lastname = lastname else {
                
            handler?(false, nil, "Номер телефона не получен")
            return
        }
        if let _ = SettingsService().userEntityId {
            AuthService().updateUserEntity(name: name, lastname: lastname) { (succeed, errorString) in
                handler?(true, nil, nil)
            }
        } else {
            AuthService().createUserEntity(phone: phone, name: name, lastname: lastname) { (userId, errorString) in
                handler?(true, userId, errorString)
            }
        }
        
    }
    
    func getNameAndLastname(_ handler: @escaping (String?, String?, String?) -> ()) { // String, String, String == name, lastname, errorString
        guard let userId = SettingsService().userEntityId else {
            handler(nil, nil, "Пользователь не найден")
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { (document, error) in
            guard let document = document, document.exists else {
                handler(nil, nil, "Пользователь не найден")
                return
            }
            let name = document.data()?["name"] as? String
            let lastname = document.data()?["lastname"] as? String
            if let error = error {
                handler(nil, nil, error.localizedDescription)
            } else {
                handler(name, lastname, nil)
            }
        }
    }
}
