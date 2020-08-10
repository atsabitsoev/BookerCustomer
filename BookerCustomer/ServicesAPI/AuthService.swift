//
//  AuthService.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 10.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseAuth

final class AuthService {
    
    var verificationId: String? {
        get {
            return UserDefaults.standard.string(forKey: "verificationId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "verificationId")
        }
    }
    
    func sendCode(toPhone phone: String,
                  handler: @escaping (String?, Error?) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationId, error) in
            if let verificationId = verificationId {
                self.verificationId = verificationId
            }
            handler(verificationId, error)
        }
    }
    
    func authenticate(verificationCode: String,
                      handler: @escaping (_ succeed: Bool, _ wasRegistered: Bool, _ error: Error?) -> ()) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId ?? "",
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                handler(false, false, error)
                return
            }
            guard let user = result?.user,
                let userInfo = result?.additionalUserInfo else {
                handler(false, false, nil)
                return
            }
            let wasRegisteredEarlier = !userInfo.isNewUser
            handler(true, wasRegisteredEarlier, nil)
            print(user)
        }
    }
}
