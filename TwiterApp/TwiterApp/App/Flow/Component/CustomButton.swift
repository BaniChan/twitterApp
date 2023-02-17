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
    static func defaultButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.buttonTitle(), for: .normal)
        button.backgroundColor = disableBackgroundColor
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }
}

