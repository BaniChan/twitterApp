//
//  CustomTextField.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit
import Foundation

struct CustomTextField {
    static let fontSize: CGFloat = 16
    static let height: CGFloat = 40
    
    static var name: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = R.color.inputText()
        textField.placeholder =  R.string.localizable.inputName()
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
    
    static var email: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = R.color.inputText()
        textField.placeholder = R.string.localizable.inputEmailAddress()
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.keyboardType = .emailAddress
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
    
    static var password: UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = R.color.inputText()
        textField.placeholder = R.string.localizable.inputPassword()
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
        textField.textColor = R.color.inputText()
        textField.placeholder = R.string.localizable.inputSamePasswordAgain()
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: CustomTextField.height).isActive = true
        return textField
    }
}
