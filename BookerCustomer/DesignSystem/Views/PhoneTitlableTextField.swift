//
//  PhoneTitlableTextField.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 29.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import PhoneNumberKit

final class PhoneTitlableTextField: TitlableTextField {
    
    override func getBaseTextField() -> UITextField {
        let textField = PhoneNumberTextField()
        textField.text = "+7"
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return textField
    }
    
    @objc private func textChanged(_ sender: UITextField) {
        guard let text = sender.text, text.count > 1 else {
            sender.text = "+7" + (sender.text ?? "")
            return
        }
        let prefix = "\(text.dropLast(text.count - 2))"
        if prefix != "+7" {
            if sender.text?.first == "+" {
                sender.text?.insert("7", at: text.index(after: text.startIndex))
            } else if sender.text?.first == "7" {
                sender.text?.insert("+", at: text.startIndex)
            } else {
                sender.text = "+7" + text
            }
        }
    }
    
}

extension PhoneTitlableTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b") == -92
            if isBackSpace {
                return textField.text != "+7"
            } else  {
                let textCount = textField.text?.count ?? 0
                if textCount == 16 { return false }
            }
        }
        return range.location != 0 && range.location != 1
    }
    
}
