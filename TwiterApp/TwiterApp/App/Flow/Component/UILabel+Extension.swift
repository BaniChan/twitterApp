//
//  UILabel+Extension.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

extension UILabel {
    static func inputFieldTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "InputFieldTitle")
        label.text = title
        label.font = UIFont.systemFont(ofSize: 18)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return label
    }
    
    static func mainTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "MainTitle")
        label.text = title
        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 0
        return label
    }
}
