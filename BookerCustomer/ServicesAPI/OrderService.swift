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
        db
            .collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .whereField("phone", isEqualTo: userPhone)
            .addSnapshotListener { [weak self] (query, error) in
                guard let documents = query?.documents else {
                    handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
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
    
    func createOrder(date: Date,
                     personNumber: Int,
                     _ handler: @escaping (Bool, String?) -> ()) {
        
        let db = Firestore.firestore()
        
        let settingsService = SettingsService()
        let restaurantId = settingsService.restaurantId
        guard let userPhone = settingsService.userPhone else {
            handler(false, "Номер телефона пользователя не получен")
            return
        }
        let profileService = ProfileService()
        let nameAndLastname = profileService.getNameAndLastname()
        let name = nameAndLastname.0
        let lastname = nameAndLastname.1
        let nameAndLastnameString = "\(name) \(lastname)"
        
        let orderDict: [String: Any] = [
            "customerName": nameAndLastnameString,
            "personNumber": personNumber,
            "phone": userPhone,
            "status": "waiting",
            "dateTime": Timestamp(date: date)
        ]
        
        db
            .collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .addDocument(data: orderDict) { (error) in
                if let error = error {
                    handler(false, error.localizedDescription)
                } else {
                    handler(true, nil)
                }
        }
    }
    
    func deleteOrder(_ handler: @escaping (Bool, String?) -> ()) {
        
        let db = Firestore.firestore()
        let settingsService = SettingsService()
        let restaurantId = settingsService.restaurantId
        guard let userPhone = settingsService.userPhone else {
            handler(false, "Номер телефона пользователя не получен")
            return
        }
        
        db.collection("restaurants").document(restaurantId).collection("orders").whereField("phone", isEqualTo: userPhone).getDocuments { (query, error) in
            if let document = query?.documents.first {
                document.reference.delete { (error) in
                    if let error = error {
                        handler(false, error.localizedDescription)
                    } else {
                        handler(true, nil)
                    }
                }
            } else {
                handler(false, error?.localizedDescription ?? "Что-то пошло не так...")
            }
        }
    }
    
    func getActiveMessage(_ handler: @escaping (_ message: String?, _ error: String?) -> ()) {
        
        let db = Firestore.firestore()
        guard let userPhone = SettingsService().userPhone else { return }
        
        db
            .collection("users")
            .whereField("phone", isEqualTo: userPhone).getDocuments { (query, error) in
                
                if let userDocument = query?.documents.first {
                    let userData = userDocument.data()
                    if let message = userData["activeMessage"] as? String, message != "" {
                        handler(message, nil)
                    }
                } else {
                    handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
                }
        }
    }
    
    func deleteMessage(_ handler: @escaping (Bool) -> ()) {
        
        let db = Firestore.firestore()
        guard let userPhone = SettingsService().userPhone else { return }
        
        db
            .collection("users")
            .whereField("phone", isEqualTo: userPhone).getDocuments { (query, error) in
                if let userDocument = query?.documents.first {
                    userDocument.reference.updateData(["activeMessage": ""]) { (error) in
                        if let _ = error {
                            handler(false)
                        } else {
                            handler(true)
                        }
                    }
                } else {
                    handler(false)
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
        let order = Order(date: dateTime, personsCount: personNumber, state: Order.State(rawValue: status) ?? .waiting, orderId: orderId)
        return order
    }
}
