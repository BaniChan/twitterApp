//
//  UIView+Extension.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

extension UIView {
    static var separator: UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(named: "Separator")
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
}
