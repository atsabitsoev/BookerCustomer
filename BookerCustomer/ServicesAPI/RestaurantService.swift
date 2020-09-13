//
//  RestaurantService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore


final class RestaurantService {
    
    func getRestaurantInfo(_ handler: @escaping (_ name: String?, _ address: String?, _ errorString: String?) -> ()) {
        
        let settingsService = SettingsService()
        let db = Firestore.firestore()
        let restaurantId = settingsService.restaurantId
        db.collection("restaurants").document(restaurantId).getDocument { (document, error) in
            if let document = document,
                let documentDict = document.data() {
                let restaurantName = documentDict["name"] as? String
                let restaurantAddress = documentDict["address"] as? String
                handler(restaurantName, restaurantAddress, nil)
            } else {
                handler(nil, nil, error?.localizedDescription ?? "Что-то пошло не так...")
            }
        }
    }
}
