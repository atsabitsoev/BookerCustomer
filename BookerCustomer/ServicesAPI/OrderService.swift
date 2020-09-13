//
//  OrderService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore


final class OrderService {
    
    func getCurrentOrderIfExist(_ handler: @escaping (Order?, String?) -> ()) {
        
        let db = Firestore.firestore()
        
        let settingsService = SettingsService()
        let restaurantId = settingsService.restaurantId
        guard let userPhone = settingsService.userPhone else {
            handler(nil, "Номер телефона пользователя не получен")
            return
        }
        db.collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .whereField("phone", isEqualTo: userPhone)
            .getDocuments { [weak self] (query, error) in
                guard let documents = query?.documents else {
                    handler(nil, error?.localizedDescription ?? "Неизвестная ошибка")
                    return
                }
                if let orderDocument = documents.first {
                    let order = self?.parseJsonToOrder(orderDocument.data(), orderId: orderDocument.documentID)
                    handler(order, nil)
                } else {
                    handler(nil, nil)
                }
        }
    }
    
    private func parseJsonToOrder(_ json: [String: Any], orderId: String) -> Order? {
        guard let dateTimeStamp = json["dateTime"] as? Timestamp,
        let personNumber = json["personNumber"] as? Int,
        let status = json["status"] as? String else {
            print("Ошибка парсинга")
            return nil
        }
        let dateTime = dateTimeStamp.dateValue()
        let order = Order(date: dateTime, personsCount: personNumber, state: status, orderId: orderId)
        return order
    }
}
