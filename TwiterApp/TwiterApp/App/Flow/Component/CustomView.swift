//
//  CustomView.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

struct CustomView {
    static var separator: UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = R.color.separator()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
}
