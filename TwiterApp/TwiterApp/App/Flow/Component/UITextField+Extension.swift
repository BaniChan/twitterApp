//
//  UITextField+Extension.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

extension UITextField {
    static let fontSize: CGFloat = 16
    static let height: CGFloat = 30
    
    static var name: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Name"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.heightAnchor.constraint(equalToConstant: UITextField.height).isActive = true
        return textField
    }
    
    static var email: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Email address"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.keyboardType = .emailAddress
        textField.heightAnchor.constraint(equalToConstant: UITextField.height).isActive = true
        return textField
    }
    
    static var password: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: UITextField.height).isActive = true
        return textField
    }
    
    static var confirmPassword: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(named: "InputText")
        textField.placeholder = "Confirm password"
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: UITextField.height).isActive = true
        return textField
    }
}
