//
//  ProfileService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 10.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseAuth

final class ProfileService {
    
    func setNewProfileInfo(
        name: String?,
        lastname: String?,
        handler: ((Error?) -> Void)? = nil
    ) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        let space = (name != nil && lastname != nil) ? " " : ""
        let name = name ?? ""
        let lastname = lastname ?? ""
        changeRequest?.displayName = name + space + lastname
        changeRequest?.commitChanges(completion: { (error) in
            handler?(error)
        })
    }
    
    func getNameAndLastname() -> (String, String) {
        let displayName = Auth.auth().currentUser?.displayName ?? ""
        let nameAndLastnameArray = displayName.components(separatedBy: " ")
        return (nameAndLastnameArray[0], nameAndLastnameArray[1])
    }
}
