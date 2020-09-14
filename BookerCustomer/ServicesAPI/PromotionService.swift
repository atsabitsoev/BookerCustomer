//
//  PromotionService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 14.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore

final class PromotionService {
    
    func getAllPromotions(_ handler: @escaping ([Promotion]?, String?) -> ()) {
        
        let db = Firestore.firestore()
        let restaurantId = SettingsService().restaurantId
        
        db.collection("restaurants").document(restaurantId).collection("promotions").addSnapshotListener { (query, error) in
            
            let promotionsDictOptional = query?.documents.map({ (document) -> [String: Any] in
                return document.data()
            })
            guard let promotionsDict = promotionsDictOptional else {
                handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
                return
            }
            
            let promotions = promotionsDict.compactMap { (promotionDict) -> Promotion? in
                if let title = promotionDict["title"] as? String,
                    let description = promotionDict["description"] as? String,
                    let image = promotionDict["image"] as? String {
                    let promotion = Promotion(title: title, description: description, image: image)
                    return promotion
                } else {
                    return nil
                }
            }
            handler(promotions, nil)
        }
    }
}
