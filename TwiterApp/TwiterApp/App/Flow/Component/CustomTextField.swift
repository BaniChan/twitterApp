//
//  CustomTextField.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

struct CustomTextField {
    static let fontSize: CGFloat = 16
    static let height: CGFloat = 40
    
    static var name: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Input name"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
    
    static var email: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Input email address"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.keyboardType = .emailAddress
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
    
    static var password: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Input password"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        // use oneTimeCode for now to dismiss keychain error
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
    
    static var confirmPassword: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Input same password again"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
}
