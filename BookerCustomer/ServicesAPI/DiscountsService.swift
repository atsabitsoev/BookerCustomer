//
//  DiscountsService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 17.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore
import EFQRCode

final class DiscountsBackendService {
    
    func getAllDiscounts(_ handler: @escaping ([Discount]?, String?) -> ()) {
        
        let db = Firestore.firestore()
        let settingsService = SettingsService()
        guard let userId = settingsService.userEntityId else {
                handler(nil, "Данные пользователя не загружены, попрообуйте еще раз")
                return
        }

        db.collection("users")
            .document(userId)
            .collection("discounts")
            .addSnapshotListener { (query, error) in
                
            guard let documents = query?.documents else {
                handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
                return
            }
                
            let discounts = documents.compactMap { (document) -> Discount? in
                guard document.exists else { return nil }
                let id = document.documentID
                guard let description = document.data()["description"] as? String else { return nil }
                let discount = Discount(id: id, description: description, userEntityId: userId)
                return discount
            }
            handler(discounts, nil)
        }
    }
    
    func createDiscount(_ discount: Discount,
                        _ handler: @escaping (Bool, String?) -> ()) {
        
        let db = Firestore.firestore()
        let newDiscountDict: [String: Any] = ["description": discount.description]
        
        db
            .collection("users")
            .document(discount.userEntityId)
            .collection("discounts")
            .document(discount.id)
            .setData(newDiscountDict) { (error) in
                if let error = error {
                    handler(false, error.localizedDescription)
                } else {
                    handler(true, nil)
                }
        }
        
    }
    
}


final class DiscountsQrService {
    
    private let devider = "•¶§∞¶∞£¢§£∞¢∞"
    
    func generateQrCode(
        discountId: String,
        discountDescription: String,
        userEntityId: String
    ) -> UIImage? {
        
        guard let cgImageQr = EFQRCode.generate(content: "\(discountId)\(devider)\(discountDescription)\(devider)\(userEntityId)") else { return nil }
        return UIImage(cgImage: cgImageQr)
    }
    
    func getDiscount(fromCode code: String) -> Discount? {
        let components = code.components(separatedBy: devider) // components: [discountId, description]
        guard components.count == 2 else { return nil }
        guard let userEntityId = SettingsService().userEntityId else { return nil }
        return Discount(id: components[0], description: components[1], userEntityId: userEntityId)
    }
}
