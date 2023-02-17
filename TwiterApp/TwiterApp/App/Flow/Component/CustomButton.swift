//
//  CustomButton.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

struct CustomButton {
    static let enableBackgroundColor = R.color.buttonBackground()
    static let disableBackgroundColor = R.color.buttonBackground_disable()
    
    static func defaultButton(_ title: String, enable: Bool = false) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.buttonTitle(), for: .normal)
        button.backgroundColor = enable ? enableBackgroundColor : disableBackgroundColor
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.isEnabled = enable
        return button
    }
    
    static var accountButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.icon_account(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }
    
    static var addPostButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.icon_post(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
    
    static var cancelButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(R.string.localizable.cancel(), for: .normal)
        button.setTitleColor(R.color.secondaryInputText(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
    
    static var postButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(R.string.localizable.post(), for: .normal)
        button.setTitleColor(R.color.buttonTitle(), for: .normal)
        button.backgroundColor = disableBackgroundColor
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }
    
    static var addPhotoButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.icon_photo(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    static var deleteButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.icon_delete(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }
}
