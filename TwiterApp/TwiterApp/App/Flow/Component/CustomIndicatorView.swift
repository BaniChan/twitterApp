//
//  CustomIndicatorView.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

struct CustomIndicatorView {
    static var loadingIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return indicator
    }
}
