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
}
